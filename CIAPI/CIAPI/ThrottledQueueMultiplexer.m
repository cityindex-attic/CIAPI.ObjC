//
//  QueueMultiplexer.m
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThrottledQueueMultiplexer.h"

@implementation ThrottledQueueMultiplexer

@synthesize stopDequeue;

- (ThrottledQueueMultiplexer*)initWithQueues:(NSArray*)queues;
{
    self = [super init];
    if (self)
    {
        allQueues = [[NSMutableArray alloc] init];
        enqueueWaitCondition = [[NSCondition alloc] init];
        
        if (queues)
            [allQueues addObjectsFromArray:queues];
    }
    
    return self;
}

- (void)dealloc
{
    [enqueueWaitCondition release];
    [allQueues release];
    
    [super dealloc];
}

- (void)setStopDequeue:(BOOL)_stopDequeue
{
    if (stopDequeue)
    {
        [enqueueWaitCondition lock];
        [enqueueWaitCondition signal];
        [enqueueWaitCondition unlock];
    }
    
    stopDequeue = _stopDequeue;
}

- (void)addQueue:(ThrottledQueue*)queue
{    
    NSAssert(queue == nil, @"Cannot add a nil queue");
    NSAssert([allQueues containsObject:queue], @"Cannot insert the same queue twice");
 
    @synchronized (allQueues)
    {
        queue.delegate = self;
        [allQueues addObject:queue];
    }
}

- (void)removeQueue:(ThrottledQueue*)queue
{
    NSAssert(queue != nil, @"Cannot remove a nil queue");
    NSAssert(![allQueues containsObject:queue], @"Cannot remove a queue that is not in the multiplexer");
    
    @synchronized (allQueues)
    {
        queue.delegate = nil;
        [allQueues removeObject:queue];
    }
}

// Dequeues an object from the multiplexed queues, 
- (id)dequeueObject
{
    // Go through our queues and find an object, storing the minimum, non-zero, wait time if none are instantly available
    NSTimeInterval waitTime = DBL_MAX;
    id dequeuedObj = nil;
    
    while (dequeuedObj == nil && !stopDequeue)
    {
        @synchronized (allQueues)
        {
            for (ThrottledQueue *queue in allQueues)
            {
                NSTimeInterval thisQueuesWaitTime;
                
                dequeuedObj = [queue dequeueObjectOrGiveWaitTime:&thisQueuesWaitTime];
                
                if (dequeuedObj != nil)
                    break;
                
                if (thisQueuesWaitTime < waitTime)
                    waitTime = thisQueuesWaitTime;
            }
        }
        
        if (dequeuedObj == nil)
        {            
            if (waitTime < DBL_MAX)
            {
                // If we know how long we'll have to wait for the next object, just wait
                [NSThread sleepForTimeInterval:waitTime];
            }
            else
            {
                // Otherwise, we need to wait for the notification that an object has been enqueued
                [enqueueWaitCondition lock];
                [enqueueWaitCondition wait];
                [enqueueWaitCondition unlock];
            }
                
        }
    }
    
    if (stopDequeue)
        stopDequeue = NO;
    
    return dequeuedObj;
}

- (void)objectEnqueued:(id)object
{
    [enqueueWaitCondition lock];
    [enqueueWaitCondition signal];
    [enqueueWaitCondition unlock];
}

@end
