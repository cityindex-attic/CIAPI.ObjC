//
//  ThrottledQueue.h
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ThrottledQueueDelegate<NSObject>

@optional
- (void)objectEnqueued:(id)object;
- (void)objectDequeued:(id)object;

@end

@interface EnqueuedThrottledObject : NSObject {
    id object;
    NSTimeInterval enqueueTime;
    NSTimeInterval minimumDequeueTime;
}

@property (retain) id object;
@property NSTimeInterval enqueueTime;
@property NSTimeInterval minimumDequeueTime;

@end

#define THROTTLED_QUEUE_CANNOT_WAIT_TIME DBL_MAX

@interface ThrottledQueue : NSObject {
@private
    // The maximum number of dequeues allowed within the throttle period
    NSUInteger throttleLimit;
    
    // The period over which the throttle is enforced
    NSTimeInterval throttlePeriod;
    
    NSMutableArray *underlyingQueue;
    NSMutableArray *recentRequestTimes;
    id<ThrottledQueueDelegate> delegate;
}

@property (readonly) NSUInteger throttleLimit;
@property (readonly) NSTimeInterval throttlePeriod;
@property (retain) id<ThrottledQueueDelegate> delegate;

/** Creates a new autoreleased ThrottledQueue that will, over any interval of the given period, not allow the dequeue of more than the
 given limited number of entries.
 
 @param limit The maximum number of entries to dequeue within any window of length period seconds
 @param period The period the limitation is enforced over
 @return An autoreleased ThrottledQueue instance
 */
+ (ThrottledQueue*)throttledQueueWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

/** Creates a new  ThrottledQueue that will, over any interval of the given period, not allow the dequeue of more than the
 given limited number of entries.
 
 @param limit The maximum number of entries to dequeue within any window of length period seconds
 @param period The period the limitation is enforced over
 @return A ThrottledQueue instance
 */
- (ThrottledQueue*)initWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

/** Enqueues a new object
 
 @param object The object to add to the back of the queue
 */
- (void)enqueueObject:(id)object;

/** Enqueues a new object, with a minimum wait time
 
 @param object The object to add to the back of the queue. It will not be dequeued for at least the given wait time
 @param minimumWaitTime The minimum time to wait before allowing this object to be dequeued. Other objects may "skip" over it in the queue if they can be
                        dequeued earlier
 */
- (void)enqueueObject:(id)object withMinimumWaitTime:(NSTimeInterval)minimumWaitTime;

/** Remove an object from the queue
 
 @param object The object to remove
 @return TRUE if the object was removed, otherwise FALSE
 */
- (BOOL)removeObject:(id)object;

/** Dequeues a object. If there are no objects, returns nil. If dequeuing any object would violate the queues throttle contraints, blocks until the dequeue will
    is permitted.
 
 @returns An object from the queue, or nil if there were none
 */
- (id)dequeueObject;

/** Dequeues a object. If there are no objects, returns nil. If dequeuing any object would violate the queues throttle contraints, sets the pointed to value of the waitTime to the length of time before a dequeue will be possible
 @param waitTime A pointer to an NSTimeInterval that will recieve either: the time that must be waited before a dequeue will be allowed; 0 if the a dequeue occured or THROTTLED_QUEUE_CANNOT_WAIT_TIME if there are no items in the queue (and so there is no known wait time)
 @returns An object from the queue, or nil if there were none
 */
- (id)dequeueObjectOrGiveWaitTime:(NSTimeInterval*)waitTime;

/** Determines the number of objects within the queue.
 
 @returns The number of objects within the queue.
 */
- (NSUInteger)count;

@end

// Private methods

@interface ThrottledQueue ()

- (void)removeStaleRecentRequestTimes;

@end