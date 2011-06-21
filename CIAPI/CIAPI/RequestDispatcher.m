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
    [inflightRequests release];
    [namedQueueMap release];
    [rkRequestToTokenMapper release];
    [queueMultiplexer release];
    
    [super dealloc];
}

- (void)scheduleRequestToken:(CIAPIRequestToken*)token
{
    // Find the queue corresponding to the request, or create one
    ThrottledQueue *queue = nil;
    @synchronized (namedQueueMap)
    {
        queue = [namedQueueMap objectForKey:token.requestObject.throttleScope];
        
        if (queue == nil)
        {
            queue = [ThrottledQueue throttledQueueWithLimit:throttleSize overPeriod:throttlePeriod];
            [namedQueueMap setObject:queue forKey:token.requestObject.throttleScope];
        }
    }
    
    // Schedule it in that queue
    [queue enqueueObject:token];
}

- (BOOL)unscheduleRequestToken:(CIAPIRequestToken*)token
{
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
    NSAssert(dispatcherShouldRun == NO, @"Cannot start the dispatcher more than once");
    dispatcherShouldRun = YES;
    
    [NSThread detachNewThreadSelector:@selector(dispatchThread:) toTarget:self withObject:nil];
}
     
- (void)stopDispatcher
{
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
        [inflightRequests addObject:requestObject];
        
        // We might have broken out of the multiplexer due to a stop request
        if (!dispatcherShouldRun)
            break;
        
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
    // Dispatch onto the main thread
    token.responseObject = result;
    [self performSelectorOnMainThread:@selector(mainThreadSuccessDispatcher:) withObject:token waitUntilDone:NO];
}

- (void)rescheduleFailedRequest:(CIAPIRequestToken*)token forLastError:(enum RequestFailureType)failureType
{
    token.responseError = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
    
    // Depending on the error, we may reschedule this request with a longer wait time
    if (token.attemptCount < maximumRequestAttempts)
        [self scheduleRequestToken:token];
    else
        [self performSelectorOnMainThread:@selector(mainThreadFailureDispatcher:) withObject:token waitUntilDone:NO];
}

- (void)mainThreadSuccessDispatcher:(CIAPIRequestToken*)token
{
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
