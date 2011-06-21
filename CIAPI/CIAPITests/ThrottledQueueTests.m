//
//  ThrottledQueueTests.m
//  CIAPI
//
//  Created by Adam Wright on 21/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThrottledQueueTests.h"

@implementation ThrottledQueueDelegateTester

@synthesize hasEnqueued;
@synthesize hasDequeued;

- (ThrottledQueueDelegateTester*)init
{
    self = [super init];
    
    if (self)
    {
        hasEnqueued = NO;
        hasDequeued = NO;
    }
    
    return self;
}

- (void)objectEnqueued:(id)object
{
    hasEnqueued = YES;
}

- (void)objectDequeued:(id)object
{
    hasDequeued = YES;
}

@end

@implementation ThrottledQueueTests

- (void)testConfiguredPropertiesAreSet
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:10.0];
    
    STAssertEquals(queue.throttleLimit, 5u, @"Queue limit not correctly set");
    STAssertEquals(queue.throttlePeriod, 10.0, @"Queue limit not correctly set");
    
    [queue release];
}

- (void)testEmptyQueueReturnsNil
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:10.0];
    
    STAssertTrue([queue dequeueObject] == nil, @"Empty queue should return nothing");
    
    [queue release];
}

- (void)testEnqueueIncreasesCount
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:5 overPeriod:10.0];
    
    [queue enqueueObject:@"Test"];
    
    STAssertEquals([queue count], 1u, @"Queue should have one object after insertion");
    
    [queue release];
}

- (void)testAddingOverLimitCreatesCorrectWaitTime
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:1 overPeriod:10.0];
    
    [queue enqueueObject:@"Test 1"];
    [queue enqueueObject:@"Test 2"];
    
    NSTimeInterval waitTime;    
    [queue dequeueObject];        
    id secondResult = [queue dequeueObjectOrGiveWaitTime:&waitTime];

    STAssertTrue(secondResult == nil, @"dequeueObjectOrGiveWaitTime when expecting a wait should return nil");
    STAssertEqualsWithAccuracy(waitTime, 10.0, 1.0, @"dequeueObjectOrGiveWaitTime in this case should give a wait time of near 10 seconds");

    [queue release];
}

- (void)testHighLimitEnqueueDequeueCycle
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:10 overPeriod:10.0];
    
    [queue enqueueObject:@"Test 1"];
    [queue enqueueObject:@"Test 2"];
    [queue enqueueObject:@"Test 3"];
    
    STAssertEquals([queue count], 3u, @"Queue should have three objects after insertion");
    
    NSTimeInterval waitTime;
    id result1 = [queue dequeueObjectOrGiveWaitTime:&waitTime];
    STAssertEquals(waitTime, 0.0, @"Should not wait for an object that is known to be within limits");
    id result2 = [queue dequeueObjectOrGiveWaitTime:&waitTime];
    STAssertEquals(waitTime, 0.0, @"Should not wait for an object that is known to be within limits");
    id result3 = [queue dequeueObjectOrGiveWaitTime:&waitTime];
    STAssertEquals(waitTime, 0.0, @"Should not wait for an object that is known to be within limits");
    
    STAssertEqualObjects(result1, @"Test 1", @"First out should be Test 1");
    STAssertEqualObjects(result2, @"Test 2", @"Second out should be Test 2");
    STAssertEqualObjects(result3, @"Test 3", @"Third out should be Test 3");
    
    [queue release];
}

- (void)testEnqueueWithWaitTimeIsEnforced
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:1 overPeriod:10.0];
    
    [queue enqueueObject:@"Test 1" withMinimumWaitTime:60.0];
    
    NSTimeInterval waitTime;
    id result = [queue dequeueObjectOrGiveWaitTime:&waitTime];
    
    STAssertTrue(result == nil, @"dequeueObjectOrGiveWaitTime when expecting a wait should return nil");
    STAssertEqualsWithAccuracy(waitTime, 60.0, 1.0, @"dequeueObjectOrGiveWaitTime for a queue containing 1 object with minimum wait time 5 seconds should need to"
                                                    "wait nearly 5 seconds");
    
    [queue release];
}

- (void)testRemoveObjectRemoves
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:1 overPeriod:10.0];
    
    id first = @"Test 1";
    id second = @"Test 2";
    
    [queue enqueueObject:first];
    [queue enqueueObject:second];    
    [queue removeObject:first];
    
    NSTimeInterval waitTime;
    id result = [queue dequeueObjectOrGiveWaitTime:&waitTime];
    
    STAssertEquals(result, second, @"After removing the first, dequeue should have returned the second object");
    STAssertEquals(waitTime, 0.0, @"Dequeuing an object should be instant if it is the first one dequeued");
    
    [queue release];
}

- (void)testDelegateCallbacks
{
    ThrottledQueue *queue = [[ThrottledQueue alloc] initWithLimit:1 overPeriod:10.0];
    ThrottledQueueDelegateTester *delegateTester = [[ThrottledQueueDelegateTester alloc] init];
    queue.delegate = delegateTester;
    
    [queue enqueueObject:@"Test 1"];
    STAssertTrue(delegateTester.hasEnqueued, @"Delegate should have been informed of enqueue");
    STAssertFalse(delegateTester.hasDequeued, @"Delegate should not have been informed of denqueue");
    
    delegateTester.hasEnqueued = NO;
    [queue dequeueObject];
    STAssertFalse(delegateTester.hasEnqueued, @"Delegate should not have been informed of enqueue");
    STAssertTrue(delegateTester.hasDequeued, @"Delegate should have been informed of denqueue");
    
    [delegateTester release];
    [queue release];
}

@end
