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

@property (nonatomic, setter = setStopDequeue:) BOOL stopDequeue;

- (ThrottledQueueMultiplexer*)initWithQueues:(NSArray*)queues;

- (void)addQueue:(ThrottledQueue*)queue;
- (void)removeQueue:(ThrottledQueue*)queue;

- (id)dequeueObject;

- (void)objectEnqueued:(id)object;

@end