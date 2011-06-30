//
//  CIAPILogging.h
//  CIAPI
//
//  Created by Adam Wright on 27/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIConfigConstants.h"

enum CIAPILogLevel
{
    CIAPILogLevelNote = 1,
    CIAPILogLevelWarn = 2,
    CIAPILogLevelError = 3
};

#define LOG_LEVEL_MAX CIAPILogLevelError

enum CIAPILogModule
{
    CIAPIUnknownModule = 1,
    CIAPICoreClientModule = 2,
    CIAPIDispatcherModule = 4,
    CIAPIResponseParsingModule = 8,
    CIAPIAuthenticationModule = 16,
    CIAPIHTTPModule = 16
};

#define LOG_MODULES_ALL (CIAPICoreClientModule | CIAPIDispatcherModule | CIAPIResponseParsingModule | CIAPIAuthenticationModule | CIAPIHTTPModule)

#ifdef DEBUG

@interface CIAPILogEntry : NSObject
{
    NSString *formattedMessage;
    int line;
    NSString *file;
    NSString *method;
    void *aboutObjectAddress;
    NSDate *dateAndTime;
    enum CIAPILogModule logModule;
    enum CIAPILogLevel logLevel;
}

@property (retain) NSString *formattedMessage;
@property int line;
@property (retain) NSString *file;
@property (retain) NSString *method;
@property void *aboutObjectAddress;
@property (retain) NSDate *dateAndTime;
@property enum CIAPILogModule logModule;
@property enum CIAPILogLevel logLevel;

- (void)dumpToNSLog;

@end

@interface CIAPILogging : NSObject
{
@private    
    NSMutableArray *logEntries;
}

+(CIAPILogging*)logger;

- (void)logMessageAtLevel:(enum CIAPILogLevel)logLevel fromFile:(char*)file line:(int)line method:(char*)method module:(enum CIAPILogModule)module aboutObject:(id)obj message:(NSString*)messageFormat, ...;

- (NSArray*)allMessages;
- (NSArray*)getMessagesFromModules:(unsigned long)modules upToLevel:(enum CIAPILogLevel)level;
- (NSArray*)getMessagesAboutObject:(id)object upToLevel:(enum CIAPILogLevel)level;
- (void)dumpMessagesFromModules:(unsigned long)modules upToLevel:(enum CIAPILogLevel)level;
- (void)dumpMessagesAboutObject:(id)object upToLevel:(enum CIAPILogLevel)level;

@end

#define CIAPILog(level, messageStr, ...) \
  [[CIAPILogging logger] logMessageAtLevel:(level) fromFile:(char*)(__FILE__) line:__LINE__ method:(char*)(__PRETTY_FUNCTION__) module:0 aboutObject:nil\
    message:(messageStr), ##__VA_ARGS__]

#define CIAPILogFromModule(level, moduleNo, messageStr, ...) \
[[CIAPILogging logger] logMessageAtLevel:(level) fromFile:(char*)(__FILE__) line:__LINE__ method:(char*)(__PRETTY_FUNCTION__) module:(moduleNo) \
  aboutObject:nil message:(messageStr), ##__VA_ARGS__]

#define CIAPILogAbout(level, moduleNo, obj, messageStr, ...) \
[[CIAPILogging logger] logMessageAtLevel:(level) fromFile:(char*)(__FILE__) line:__LINE__ method:(char*)(__PRETTY_FUNCTION__) module:(moduleNo) \
    aboutObject:(obj) message:(messageStr), ##__VA_ARGS__]

#define CIAPILogGetForObject(obj) [[CIAPILogging logger] getMessagesAboutObject:(obj) upToLevel:CIAPILogLevelError]
#define CIAPILogErrorDictForObject(obj) [NSDictionary dictionaryWithObject:[[CIAPILogging logger] getMessagesAboutObject:(obj) upToLevel:CIAPILogLevelError] forKey:@"CIAPI_ERROR_LOG"]

#else

#define CIAPILog(level, messageStr, ...)
#define CIAPILogFromModule(level, moduleNo, messageStr, ...)
#define CIAPILogAbout(level, moduleNo, obj, messageStr, ...)
#define CIAPILogErrorDictForObject(obj) [NSDictionary dictionary]

#endif