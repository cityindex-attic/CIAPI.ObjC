//
//  QueueMultiplexerTests.h
//  CIAPI
//
//  Created by Adam Wright on 21/06/2011.

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

@interface ThrottledQueueMultiplexerTests : SenTestCase

- (void)testSingleQueueActsAsThrottledQueue;
- (void)testMultipleQueuesGiveSensibleResults;
- (void)testOneQueueAtLimitDoesNotStallOthers;

@end
