//
//  ThrottledQueue.h
//  CIAPI
//
//  Created by Adam Wright on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
}

@property (readonly) NSUInteger throttleLimit;
@property (readonly) NSTimeInterval throttlePeriod;

+ (ThrottledQueue*)throttledQueueWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

- (ThrottledQueue*)initWithLimit:(NSUInteger)limit overPeriod:(NSTimeInterval)period;

- (void)enqueueObject:(id)object;
- (void)enqueueObject:(id)object withMinimumWaitTime:(NSTimeInterval)minimumWaitTime;

- (id)dequeueObject;

- (NSUInteger)count;

@end

// Private methods

@interface ThrottledQueue ()

- (void)removeStaleRecentRequestTimes;

@end