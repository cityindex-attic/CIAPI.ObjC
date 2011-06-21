//
//  ThrottledQueue.m
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThrottledQueue.h"

@implementation EnqueuedThrottledObject

@synthesize object;
@synthesize enqueueTime;
@synthesize minimumDequeueTime;

- (void)dealloc
{
    [object release];
    [super dealloc];
}

@end

@implementation ThrottledQueue

+ (ThrottledQueue*)throttledQueueWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period
{
    return [[[ThrottledQueue alloc] initWithLimit:limit overPeriod:period] autorelease];
}

@synthesize throttleLimit;
@synthesize throttlePeriod;
@synthesize delegate;

- (ThrottledQueue*)initWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period
{
    self = [super init];
    
    if (self)
    {
        NSAssert(limit > 0, @"Throttles must have positive, non-zero limits");
        NSAssert(period > 0.0, @"Throttles must have positive, non-zero periods");
        
        throttleLimit = limit;
        throttlePeriod = period;
        underlyingQueue = [[NSMutableArray alloc] init];
        recentRequestTimes = [[NSMutableArray alloc] init];
        delegate = nil;
    }
    
    return self;
}

- (void)dealloc
{
    @synchronized (underlyingQueue)
    {
        @synchronized (recentRequestTimes)
        {
            [underlyingQueue release];
            [recentRequestTimes release];
            
            underlyingQueue = nil;
            recentRequestTimes = nil;
        }
    }
    
    [delegate release];

    [super dealloc];
}

- (void)enqueueObject:(id)object
{
    [self enqueueObject:object withMinimumWaitTime:0.0];
}

- (void)enqueueObject:(id)object withMinimumWaitTime:(NSTimeInterval)minimumWaitTime
{
    EnqueuedThrottledObject *obj = [[EnqueuedThrottledObject alloc] init];
    obj.object = object;
    obj.enqueueTime = [NSDate timeIntervalSinceReferenceDate];
    obj.minimumDequeueTime = minimumWaitTime;
    
    @synchronized (underlyingQueue)
    {
        [underlyingQueue addObject:obj];
    }
    
    if ([delegate respondsToSelector:@selector(objectEnqueued:)])
        [delegate objectEnqueued:obj];
    
    [obj release];
}

- (BOOL)removeObject:(id)object
{
    @synchronized (underlyingQueue)
    {
        for (EnqueuedThrottledObject *carrierObject in underlyingQueue)
        {
            if (carrierObject.object == object || [carrierObject.object isEqual:object])
            {
                [underlyingQueue removeObject:carrierObject];
                return YES;
            }
        }
        
        return NO;
    }
}

- (id)dequeueObject
{
    id obj;
    NSTimeInterval waitTime;
    
    // Spin, waiting for an object, bailing if there are no objects
    while ((obj = [self dequeueObjectOrGiveWaitTime:&waitTime]) == nil)
    {
        if (waitTime == THROTTLED_QUEUE_CANNOT_WAIT_TIME)
            return nil;
        
        [NSThread sleepForTimeInterval:waitTime];
    }
    
    return obj;
}

- (id)dequeueObjectOrGiveWaitTime:(NSTimeInterval*)waitTime
{
    // If there are no objects, fail and give a 0 wait time to indicate this
    @synchronized (underlyingQueue)
    {
        if ([underlyingQueue count] == 0)
        {
            if (waitTime != NULL)
                *waitTime = THROTTLED_QUEUE_CANNOT_WAIT_TIME;
            
            return nil;
        }
    }
    
    // Synchronize on the request times queue to block all other dequeues until this one passes
    // We do *not* block enqueues or count requests
    @synchronized (recentRequestTimes)
    {
        // We need to see if we can dequeue an object within our throttle settings
        // First, kill off any expired dequeue request times
        [self removeStaleRecentRequestTimes];
        
        // If we have no more room for more requests, we'll have to wait until the oldest has expired
        if ([recentRequestTimes count] >= throttleLimit)
        {
            NSNumber *eldestRequest = [recentRequestTimes objectAtIndex:0];
            NSTimeInterval timeToWait = [eldestRequest doubleValue] + throttlePeriod - [NSDate timeIntervalSinceReferenceDate];
            
            // If we actually have to wait, return the wait time and fail
            if (timeToWait > 0)
            {
                if (waitTime != NULL)
                    *waitTime = timeToWait;
                return nil;
            }
            
            // Otherwise, expire the eldest, which suddenly became available
            [recentRequestTimes removeObjectAtIndex:0];
        }
        
        // Try to perform the dequeue        
        @synchronized (underlyingQueue)
        {
            // We cannot dequeue an object until it's minimum wait time is up. Cycle objects until we find one
            int objectToTry = 0;
            EnqueuedThrottledObject *obj = nil;
            
            while (objectToTry < [underlyingQueue count])
            {
                EnqueuedThrottledObject *tryingObj = [underlyingQueue objectAtIndex:objectToTry];
            
                // If we can't dequeue this object yet, go around again
                if (tryingObj.enqueueTime + tryingObj.minimumDequeueTime > [NSDate timeIntervalSinceReferenceDate])
                {
                    objectToTry++;
                }
                else
                {
                    obj = tryingObj;
                    break;
                }
            }
            
            // If we didn't find one, see how long we'll have to wait
            if (obj == nil)
            {
                obj = [underlyingQueue objectAtIndex:0];
                NSTimeInterval timeToWait = obj.enqueueTime + obj.minimumDequeueTime - [NSDate timeIntervalSinceReferenceDate];
                
                // If we actually have to wait, return the wait time and fail
                if (timeToWait > 0)
                {
                    if (waitTime != NULL)
                        *waitTime = timeToWait;
                    return nil;
                }
            }
            
            // We have an object that we are allowed to dequeue
            NSNumber *dequeueTime = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
            *waitTime = 0.0;            
            [recentRequestTimes addObject:dequeueTime];
            
            // Ensure we return a valid reference to the contained object (the queue might be the last holder)
            id underlyingObj = [[obj.object retain] autorelease];
            [underlyingQueue removeObject:obj];
            
            if ([delegate respondsToSelector:@selector(objectDequeued:)])
                [delegate objectDequeued:underlyingObj];
            
            return underlyingObj;
        }
    }
}

- (NSUInteger)count
{
    @synchronized (underlyingQueue)
    {
        return [underlyingQueue count];
    }
}

/*
 * Private methods
 */

// Must be called within a synchronized block
- (void)removeStaleRecentRequestTimes
{
    NSMutableArray *staleTimes = [NSMutableArray array];
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    
    for (NSNumber *time in recentRequestTimes)
    {
        if ([time doubleValue] + throttlePeriod < now)
            [staleTimes addObject:time];
    }
    
    [recentRequestTimes removeObjectsInArray:staleTimes];
}

@end
