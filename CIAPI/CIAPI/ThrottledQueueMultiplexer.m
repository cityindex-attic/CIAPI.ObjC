//
//  QueueMultiplexer.m
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThrottledQueueMultiplexer.h"

#import "CIAPILogging.h"

@implementation ThrottledQueueMultiplexer

@synthesize stopDequeue;

- (ThrottledQueueMultiplexer*)initWithQueues:(NSArray*)queues;
{
    self = [super init];
    if (self)
    {
        CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Creating queue multiplexer");
        
        allQueues = [[NSMutableArray alloc] init];
        enqueueWaitCondition = [[NSCondition alloc] init];
        
        if (queues)
            [allQueues addObjectsFromArray:queues];
    }
    
    return self;
}

- (void)dealloc
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Destroying queue multiplexer");
    
    @synchronized (allQueues)
    {
        [enqueueWaitCondition release];
        [allQueues release];
    }
    
    [super dealloc];
}

- (void)setStopDequeue:(BOOL)_stopDequeue
{
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Setting queue multiplexer to stop status: %@", _stopDequeue ? @"TRUE" : @"FALSE");
    
    stopDequeue = _stopDequeue;
    
    if (stopDequeue)
    {
        [enqueueWaitCondition lock];
        [enqueueWaitCondition signal];
        [enqueueWaitCondition unlock];
    }
}

- (void)addQueue:(ThrottledQueue*)queue
{
    NSAssert(queue != nil, @"Cannot add a nil queue");
    NSAssert(![allQueues containsObject:queue], @"Cannot insert the same queue twice");
 
    CIAPILogAbout(LogLevelNote, DispatcherModule, queue, @"Adding queue %X to queue multiplexer", queue);
    
    @synchronized (allQueues)
    {
        queue.delegate = self;
        [allQueues addObject:queue];
        
        // Fire the wait signal, as we might have an object waiting now
        [enqueueWaitCondition lock];
        [enqueueWaitCondition signal];
        [enqueueWaitCondition unlock];
    }
}

- (void)removeQueue:(ThrottledQueue*)queue
{
    NSAssert(queue == nil, @"Cannot remove a nil queue");
    NSAssert([allQueues containsObject:queue], @"Cannot remove a queue that is not in the multiplexer");
    
    CIAPILogAbout(LogLevelNote, DispatcherModule, queue, @"Removing queue %X from queue multiplexer", queue);
    
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
    
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Dequeuing object from multiplexed queue");
    
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
            if (waitTime != THROTTLED_QUEUE_CANNOT_WAIT_TIME)
            {
                // If we know how long we'll have to wait for the next object, just wait
                // TODO: In principle, if another queue is added in the background with an object available sooner than waitTime, this waits too long
                CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Multiplexed queue is sleeping %d to wait for next object", waitTime);
                [NSThread sleepForTimeInterval:waitTime];
            }
            else
            {
                // Otherwise, we need to wait for the notification that an object has been enqueued
                CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Multiplexed queue is sleeping until enqueue condition is met");
                
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
    CIAPILogAbout(LogLevelNote, DispatcherModule, self, @"Kicking multiplexed queue, as object enqueue notification recieved");
    
    [enqueueWaitCondition lock];
    [enqueueWaitCondition signal];
    [enqueueWaitCondition unlock];
}

@end
