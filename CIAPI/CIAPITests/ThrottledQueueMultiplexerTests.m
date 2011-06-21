//
//  QueueMultiplexerTests.m
//  CIAPI
//
//  Created by Adam Wright on 21/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThrottledQueueMultiplexerTests.h"

#import "ThrottledQueueMultiplexer.h"

@implementation ThrottledQueueMultiplexerTests

- (void)testSingleQueueActsAsThrottledQueue
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    ThrottledQueueMultiplexer *multiplexer = [[ThrottledQueueMultiplexer alloc] initWithQueues:[NSArray arrayWithObject:queue]];
    
    id first = @"Test";
    id second = @"Test 2";
    
    [queue enqueueObject:first];
    [queue enqueueObject:second withMinimumWaitTime:0.2];
    
    
    id firstResult = [multiplexer dequeueObject];
    NSTimeInterval beforeSecondDequeue = [NSDate timeIntervalSinceReferenceDate];
    id secondResult = [multiplexer dequeueObject];
    NSTimeInterval afterSecondDequeue = [NSDate timeIntervalSinceReferenceDate];
    
    STAssertEquals(first, firstResult, @"First in should be first out");
    STAssertEquals(second, secondResult, @"Second in should be second out");
    STAssertEqualsWithAccuracy(afterSecondDequeue - beforeSecondDequeue, 0.2, 0.05, @"Second dequeue should have been slightly delayed");
    
    [multiplexer release];
    [queue release];
}

- (void)testMultipleQueuesGiveSensibleResults
{
    ThrottledQueue *firstQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    ThrottledQueue *secondQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    ThrottledQueue *thirdQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    
    ThrottledQueueMultiplexer *multiplexer = [[ThrottledQueueMultiplexer alloc] initWithQueues:[NSArray arrayWithObjects:firstQueue, secondQueue, nil]];
    [multiplexer addQueue:thirdQueue];
    
    id first = @"Test";
    id second = @"Test 2";
    id third = @"Test 3";
    id fourth = @"Test 4";
    
    [firstQueue enqueueObject:first];
    [secondQueue enqueueObject:second];
    [secondQueue enqueueObject:third];
    [thirdQueue enqueueObject:fourth];
    
    id firstResult = [multiplexer dequeueObject];    
    id secondResult = [multiplexer dequeueObject];
    id thirdResult = [multiplexer dequeueObject];
    id fourthResult = [multiplexer dequeueObject];

    STAssertEquals(first, firstResult, @"First in should be first out");
    STAssertEquals(second, secondResult, @"Second in should be first out");
    STAssertEquals(third, thirdResult, @"Third in should be third out");
    STAssertEquals(fourth, fourthResult, @"Fourth in should be fourth out");
    
    [multiplexer release];
    [thirdQueue release];
    [secondQueue release];
    [firstQueue release];
}

- (void)testOneQueueAtLimitDoesNotStallOthers
{
    ThrottledQueue *firstQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    ThrottledQueue *secondQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    ThrottledQueue *thirdQueue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:5.0];
    
    ThrottledQueueMultiplexer *multiplexer = [[ThrottledQueueMultiplexer alloc] initWithQueues:[NSArray arrayWithObjects:firstQueue, secondQueue, nil]];
    [multiplexer addQueue:thirdQueue];
    
    id first = @"Test";
    id second = @"Test 2";
    id third = @"Test 3";
    id fourth = @"Test 4";
    
    [firstQueue enqueueObject:first];
    [secondQueue enqueueObject:second];
    [secondQueue enqueueObject:third withMinimumWaitTime:0.2];
    [thirdQueue enqueueObject:fourth];
    
    id firstResult = [multiplexer dequeueObject];    
    id secondResult = [multiplexer dequeueObject];
    id thirdResult = [multiplexer dequeueObject];
    id fourthResult = [multiplexer dequeueObject];
    
    // Notice the sneaky delay on the third item, which should push it back to last in the queue
    STAssertEquals(first, firstResult, @"First in should be first out");
    STAssertEquals(second, secondResult, @"Second in should be first out");
    STAssertEquals(third, fourthResult, @"Third in should be last out");
    STAssertEquals(fourth, thirdResult, @"Fourth in should be third out");
    
    [multiplexer release];
    [thirdQueue release];
    [secondQueue release];
    [firstQueue release];
}

@end
