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

@implementation RequestDispatcher

@synthesize maximumRequestAttempts;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        namedQueueMap = [[NSMutableDictionary alloc] init];
        rkRequestToTokenMapper = [[NSMutableDictionary alloc] init];
        queueMultiplexer = [[ThrottledQueueMultiplexer alloc] init];
        
        // Create one global queue
        // TODO: Give it better queuing values
        [namedQueueMap setObject:[ThrottledQueue throttledQueueWithLimit:10 overPeriod:10] forKey:@"global"];
    }
    
    return self;
}

- (void)dealloc
{
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
            queue = [ThrottledQueue throttledQueueWithLimit:10 overPeriod:10];
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
    NSAssert(dispatcherShouldRun == YES, @"Cannot start the dispatcher more than once");
    dispatcherShouldRun = YES;
    
    [NSThread detachNewThreadSelector:@selector(dispatchThread) toTarget:self withObject:nil];
}
     
- (void)stopDispatcher
{
    NSAssert(dispatcherShouldRun == NO, @"Cannot stop the dispatcher more than once");
    
    queueMultiplexer.stopDequeue = YES;
    dispatcherShouldRun = NO;
}

- (void)dispatchThread:(id)ignore
{
    while (dispatcherShouldRun)
    {
        CIAPIRequestToken *requestObject = [queueMultiplexer dequeueObject];
        
        // We might have broken out of the multiplexer due to a stop request
        if (!dispatcherShouldRun)
            break;
        
        // Send the request
        requestObject.attemptCount = requestObject.attemptCount++;
        requestObject.underlyingRequest.delegate = self;
        [requestObject.underlyingRequest send];
    }
}

/*
 * Private methods
 */

- (void)rescheduleRequest:(CIAPIRequestToken*)token forLastError:(int)error
{
    // Depending on the error, we may reschedule this request with a longer wait time
}

/*
 * RestKit delegate methods
 */
- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    
}

- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
    
}

- (void)requestDidTimeout:(RKRequest *)request
{
    
}

@end
