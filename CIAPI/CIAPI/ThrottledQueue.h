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

+ (ThrottledQueue*)throttledQueueWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

- (ThrottledQueue*)initWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

- (void)enqueueObject:(id)object;
- (void)enqueueObject:(id)object withMinimumWaitTime:(NSTimeInterval)minimumWaitTime;

- (BOOL)removeObject:(id)object;
- (id)dequeueObject;
- (id)dequeueObjectOrGiveWaitTime:(NSTimeInterval*)waitTime;

- (NSUInteger)count;

- (BOOL)canCurrentlyDequeueObject;

@end

// Private methods

@interface ThrottledQueue ()

- (void)removeStaleRecentRequestTimes;

@end