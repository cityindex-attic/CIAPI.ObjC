//
//  QueueMultiplexer.h
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ThrottledQueue.h"

@interface ThrottledQueueMultiplexer : NSObject<ThrottledQueueDelegate> {
    NSMutableArray *allQueues;
    NSCondition *enqueueWaitCondition;
    BOOL stopDequeue;
}

/** Set to YES to stop one blocking dequeue operation that is in progress.
 */
@property (nonatomic, setter = setStopDequeue:) BOOL stopDequeue;

/** Creates a new  ThrottledQueueMultiplexer that will multiplex the given array of queues.
 
 @param queues An NSArray of the ThrottledQueue instances to multiplex
 @return A ThrottledQueue instance
 */
- (ThrottledQueueMultiplexer*)initWithQueues:(NSArray*)queues;

/** Adds a new queue to the list of multiplexed queues.
 
 @param queue The queue to multiplex
 */
- (void)addQueue:(ThrottledQueue*)queue;

/** Removes a queue from the list of multiplexed queues.
 
 @param queue The queue to stop multiplexing
 */
- (void)removeQueue:(ThrottledQueue*)queue;

/** Dequeues an item from the first available queue in the list of multiplexed throttled queues. Blocks until there is an item to return.
 
 @return An item from one of the multiplexed queues
 */
- (id)dequeueObject;

// Internal delegate method, do not call
- (void)objectEnqueued:(id)object;

@end