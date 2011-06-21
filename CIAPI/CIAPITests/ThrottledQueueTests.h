//
//  ThrottledQueueTests.h
//  CIAPI
//
//  Created by Adam Wright on 21/06/2011.

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "ThrottledQueue.h"

@interface ThrottledQueueDelegateTester : NSObject<ThrottledQueueDelegate>
{
    BOOL hasEnqueued;
    BOOL hasDequeued;
}

@property BOOL hasEnqueued;
@property BOOL hasDequeued;

@end

@interface ThrottledQueueTests : SenTestCase

- (void)testConfiguredPropertiesAreSet;
- (void)testEmptyQueueReturnsNil;
- (void)testEnqueueIncreasesCount;
- (void)testAddingOverLimitCreatesCorrectWaitTime;
- (void)testHighLimitEnqueueDequeueCycle;
- (void)testEnqueueWithWaitTimeIsEnforced;
- (void)testRemoveObjectRemoves;
- (void)testDelegateCallbacks;

@end
