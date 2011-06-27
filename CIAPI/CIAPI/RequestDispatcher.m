//
//  RequestDispatcher.m
//  CIAPI
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RequestDispatcher.h"

#import "ThrottledQueue.h"

#import "CIAPIRequestToken.h"
#import "CIAPIObjectRequest.h"
#import "CIAPIObjectResponse.h"

#import "CIAPILogging.h"

#import "RestKit/RestKit.h"

@implementation RequestDispatcher

@synthesize maximumRequestAttempts;
@synthesize throttleSize;
@synthesize throttlePeriod;

- (RequestDispatcher*)initWithMaximumRetryAttempts:(NSUInteger)_maximumRequestAttempts throttleSize:(NSUInteger)_throttleSize
                                    throttlePeriod:(NSTimeInterval)_throttlePeriod;
{
    self = [super init];
    
    if (self)
    {
        CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Creating RequestDispatcher with maxAttempt %u, throttle size %u, throttle period %d",
                      _maximumRequestAttempts, _throttleSize, _throttlePeriod);
        
        maximumRequestAttempts = _maximumRequestAttempts;
        throttleSize = _throttleSize;
        throttlePeriod = _throttlePeriod;
        
        namedQueueMap = [[NSMutableDictionary alloc] init];
        rkRequestToTokenMapper = [[NSMutableDictionary alloc] init];
        queueMultiplexer = [[ThrottledQueueMultiplexer alloc] init];
        inflightRequests = [[NSMutableArray alloc] init];
        
        // Create one global queue
        // TODO: Give it better queuing values
        [namedQueueMap setObject:[ThrottledQueue throttledQueueWithLimit:throttleSize overPeriod:throttlePeriod] forKey:@"global"];
    }
    
    return self;
}

- (void)dealloc
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Destroying RequestDispatcher");
    
    [inflightRequests release];
    [namedQueueMap release];
    [rkRequestToTokenMapper release];
    [queueMultiplexer release];
    
    [super dealloc];
}

- (void)scheduleRequestToken:(CIAPIRequestToken*)token
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, token, @"Scheduling dispatch of request token %X", token);
    
    // Find the queue corresponding to the request, or create one
    ThrottledQueue *queue = nil;
    @synchronized (namedQueueMap)
    {
        queue = [namedQueueMap objectForKey:token.requestObject.throttleScope];
        
        if (queue == nil)
        {
            CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Creating a new request queue for throttle scope %@", token.requestObject.throttleScope);
            queue = [ThrottledQueue throttledQueueWithLimit:throttleSize overPeriod:throttlePeriod];
            [namedQueueMap setObject:queue forKey:token.requestObject.throttleScope];
        }
    }
    
    // Schedule it in that queue
    [queue enqueueObject:token];
}

- (BOOL)unscheduleRequestToken:(CIAPIRequestToken*)token
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, token, @"Unscheduling dispatch of request token %X", token);
    
    // Find the queue corresponding to the request
    ThrottledQueue *queue = nil;
    @synchronized (namedQueueMap)
    {
        queue = [namedQueueMap objectForKey:token.requestObject.throttleScope];
        
        NSAssert(queue != nil, @"Should not be able to reach a state where one is dequeuing an object from a non-existant queue!");
    }
    
    // De-schedule it in that queue, if we can
    return [queue removeObject:token];
}

- (void)startDispatcher
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Starting dispatcher dispatch loop");
    
    NSAssert(dispatcherShouldRun == NO, @"Cannot start the dispatcher more than once");
    dispatcherShouldRun = YES;
    
    [NSThread detachNewThreadSelector:@selector(dispatchThread:) toTarget:self withObject:nil];
}
     
- (void)stopDispatcher
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Stopping dispatcher dispatch loop");
    NSAssert(dispatcherShouldRun == YES, @"Cannot stop the dispatcher more than once");
    
    queueMultiplexer.stopDequeue = YES;
    dispatcherShouldRun = NO;
}

- (void)dispatchThread:(id)ignore
{
    [self retain];
    
    while (dispatcherShouldRun)
    {
        CIAPIRequestToken *requestObject = [queueMultiplexer dequeueObject];
        
        // We might have broken out of the multiplexer due to a stop request
        if (!dispatcherShouldRun)
        {
            CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Stopping dispatch loop due to user request");
            break;
        }
        
        if (!requestObject)
        {
            // The multiplexer has quit, hopefully due to user request, so we'll spin until we're asked to do the same
            continue;
        }
        
        [inflightRequests addObject:requestObject];
        
        CIAPILogAbout(LogLevelNote, DispatcherModule, requestObject, @"Actually dispatching token %X", requestObject);
        
        // Send the request
        requestObject.attemptCount = requestObject.attemptCount++;
        [requestObject.underlyingRequest setDelegate: self];
        [requestObject.underlyingRequest send];
    }
    
    [self release];
}

/*
 * Private methods
 */

- (void)dispatchSuccessfulRequest:(CIAPIRequestToken*)token result:(id)result
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, token, @"Dispatch response SUCCEEDED for token %X", token);
    
    // Dispatch onto the main thread
    token.responseObject = result;
    [self performSelectorOnMainThread:@selector(mainThreadSuccessDispatcher:) withObject:token waitUntilDone:NO];
}

- (void)rescheduleFailedRequest:(CIAPIRequestToken*)token forLastError:(enum RequestFailureType)failureType
{
    CIAPILogAbout(LogLevelWarn, DispatcherModule, token, @"Dispatch response FAILED for token %X", token);
    token.responseError = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
    
    // Depending on the error, we may reschedule this request with a longer wait time
    if (token.attemptCount < maximumRequestAttempts)
        [self scheduleRequestToken:token];
    else
        [self performSelectorOnMainThread:@selector(mainThreadFailureDispatcher:) withObject:token waitUntilDone:NO];
}

- (void)mainThreadSuccessDispatcher:(CIAPIRequestToken*)token
{
    CIAPILogAbout(LogLevelWarn, DispatcherModule, token, @"Main thread callback happening for token %X", token);
    
    if (token.callbackDelegate)
        [token.callbackBlock requestSucceeded:token result:token.responseObject];
    else if (token.callbackBlock)
        token.callbackBlock(token, token.responseObject, nil);
    else
        NSAssert(FALSE, @"Trying to dispatch a result, but was given neither delegate or block!");
    
    // TODO: Remove the token from the token mapping dictionary (the only thing keeping it alive)
}

- (void)mainThreadFailureDispatcher:(CIAPIRequestToken*)token
{
    CIAPILogAbout(LogLevelWarn, DispatcherModule, token, @"Main thread callback happening for token %X", token);
    
    if (token.callbackDelegate)
        [token.callbackDelegate requestFailed:token error:token.responseError];
    else if (token.callbackBlock)
        token.callbackBlock(token, nil, token.responseError);
    else
        NSAssert(FALSE, @"Trying to dispatch a result, but was given neither delegate or block!");
    
    // TODO: Remove the token from the token mapping dictionary (the only thing keeping it alive)
}

/*
 * RestKit delegate methods
 */
- (void)request:(RKRequest*)rkRequest didLoadResponse:(id)rkResponse
{
    CIAPIRequestToken *token = [rkRequestToTokenMapper objectForKey:rkRequest];
    if (!token)
        NSAssert(FALSE, @"We got a response for a request we never issued?");
    [inflightRequests removeObject:token];
    
    if ([rkResponse isOK])
    {
        // Decode the resultant object JSON into the response type
        id bodyObj = [rkResponse bodyAsJSON];
        
        CIAPIObjectResponse *responseObj = [[[token.requestObject responseClass] alloc] init];
        [responseObj setupFromDictionary:bodyObj error:nil];
        
        [self dispatchSuccessfulRequest:token result:responseObj];
        
        [responseObj release];
    }
    else
    {
        [self rescheduleFailedRequest:token forLastError:RequestUnknownError];
    }
}

- (void)request:(RKRequest*)rkRequest didFailLoadWithError:(NSError *)error
{
    CIAPIRequestToken *token = [rkRequestToTokenMapper objectForKey:rkRequest];    
    if (!token)
        NSAssert(FALSE, @"We got a response for a request we never issued?");
    [inflightRequests removeObject:token];
    
    [self rescheduleFailedRequest:token forLastError:RequestUnknownError];
}

- (void)requestDidTimeout:(RKRequest*)rkRequest
{
    CIAPIRequestToken *token = [rkRequestToTokenMapper objectForKey:rkRequest];    
    if (!token)
        NSAssert(FALSE, @"We got a response for a request we never issued?");
    [inflightRequests removeObject:token];
    
    [self rescheduleFailedRequest:token forLastError:RequestUnknownError];
}

@end
