//
//  LoggingTests.h
//  CIAPI
//
//  Created by Adam Wright on 28/06/2011.

#import <SenTestingKit/SenTestingKit.h>

@interface LoggingTests : SenTestCase

- (void)testSimpleLogging;
- (void)testLogMessageFormatting;
- (void)testLogFilteringOnLevel;
- (void)testLogFilteringOnModule;
- (void)testLogFilteringOnObject;

@end
