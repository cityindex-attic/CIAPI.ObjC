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
        NSAssert(limit, @"Throttles must have positive, non-zero limits");
        NSAssert(period, @"Throttles must have positive, non-zero periods");
        
        throttleLimit = limit;
        throttlePeriod = period;
        underlyingQueue = [[NSMutableArray alloc] init];
        recentRequestTimes = [[NSMutableArray alloc] init];
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

    [super dealloc];
}

- (void)enqueueObject:(id)object
{
    [self enqueueObject:object withMinimumWaitTime:0];
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
        [delegate objectDequeued:obj];
    
    [obj release];
}

- (BOOL)removeObject:(id)object
{
    @synchronized (underlyingQueue)
    {
        if ([underlyingQueue containsObject:object])
        {
            [underlyingQueue removeObject:object];
            return YES;
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
        if (waitTime == 0)
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
                *waitTime = DBL_MAX;
            
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
                if (obj.enqueueTime + obj.minimumDequeueTime > [NSDate timeIntervalSinceReferenceDate])
                    objectToTry++;
                else
                    obj = tryingObj;
            }
            
            // If we didn't find one, we'll wait until the first one is available
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
            
            NSNumber *dequeueTime = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
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

- (BOOL)canCurrentlyDequeueObject
{
    @synchronized (recentRequestTimes)
    {
        [self removeStaleRecentRequestTimes];
        
        return ([recentRequestTimes count] < throttleLimit);
    }
}

/*
 * Private methods
 */
         
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
