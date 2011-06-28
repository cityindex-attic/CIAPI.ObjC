//
//  LoggingTests.m
//  CIAPI
//
//  Created by Adam Wright on 28/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoggingTests.h"

#import "CIAPILogging.h"

@implementation LoggingTests

- (void)testSimpleLogging
{
    CIAPILogging *logger = [[CIAPILogging alloc] init];
    
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    
    NSArray *allMessages = [logger allMessages];
    
    NSArray *filteredMessages = [allMessages filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CIAPILogEntry *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.formattedMessage isEqualToString:@"No Message"];
    }]];
    
    STAssertEquals([filteredMessages count], 3u, @"Should have three messages");
    
    [logger release];
}

- (void)testLogMessageFormatting
{
    CIAPILogging *logger = [[CIAPILogging alloc] init];
    
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"Hello %@ %d", @"World", 123];

    NSArray *allMessages = [logger allMessages];
    
    STAssertEquals([allMessages count], 1u, @"Should have one message");
    STAssertEqualObjects([[allMessages objectAtIndex:0] formattedMessage], @"Hello World 123", @"Message should have been formatted");
    
    [logger release];
}

- (void)testLogFilteringOnLevel
{
    CIAPILogging *logger = [[CIAPILogging alloc] init];
    
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelError fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    
    NSArray *filteredMessages = [logger getMessagesFromModules:LOG_MODULES_ALL upToLevel:CIAPILogLevelWarn];
    STAssertEquals([filteredMessages count], 4u, @"Should have four messages at note and warn level");

    [logger release];
}

- (void)testLogFilteringOnModule
{
    CIAPILogging *logger = [[CIAPILogging alloc] init];
    
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPICoreClientModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPIResponseParsingModule aboutObject:nil message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelError fromFile:"" line:0 method:"" module:CIAPIUnknownModule aboutObject:nil message:@"No Message"];
    
    NSArray *filteredMessages = [logger getMessagesFromModules:CIAPIDispatcherModule upToLevel:LOG_LEVEL_MAX];
    STAssertEquals([filteredMessages count], 2u, @"Should have 2 messages in Dispatcher module");

    filteredMessages = [logger getMessagesFromModules:(CIAPICoreClientModule | CIAPIDispatcherModule) upToLevel:LOG_LEVEL_MAX];
    STAssertEquals([filteredMessages count], 3u, @"Should have 3 messages in Dispatcher and Core Client modules");
    
    [logger release];
}

- (void)testLogFilteringOnObject
{
    CIAPILogging *logger = [[CIAPILogging alloc] init];
    NSString *firstObj = [NSString stringWithString:@"One"];
    NSString *secondObj = [NSString stringWithString:@"Two"];
    
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:firstObj message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPICoreClientModule aboutObject:firstObj message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelNote fromFile:"" line:0 method:"" module:CIAPIDispatcherModule aboutObject:secondObj message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelWarn fromFile:"" line:0 method:"" module:CIAPIResponseParsingModule aboutObject:firstObj message:@"No Message"];
    [logger logMessageAtLevel:CIAPILogLevelError fromFile:"" line:0 method:"" module:CIAPIUnknownModule aboutObject:secondObj message:@"No Message"];
    
    NSArray *filteredMessages = [logger getMessagesAboutObject:firstObj upToLevel:LOG_LEVEL_MAX];
    STAssertEquals([filteredMessages count], 3u, @"Should have 3 messages about first object");
    
    [logger release];
}


@end
