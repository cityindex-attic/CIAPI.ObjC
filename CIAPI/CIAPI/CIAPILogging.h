//
//  CIAPILogging.h
//  CIAPI
//
//  Created by Adam Wright on 27/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum LogLevel
{
    LogLevelNote = 1,
    LogLevelWarn = 2,
    LogLevelError = 3
};

enum LogModule
{
    UnknownModule = 0,
    CoreClientModule = 1,
    DispatcherModule = 2,
    ResponseParsingModule = 4,
};

#ifdef DEBUG

#define ALSO_NS_LOG TRUE
#define ALSO_NS_LOG_MIN_LEVEL 0

@interface CIAPILogEntry : NSObject
{
    NSString *formattedMessage;
    int line;
    NSString *file;
    NSString *method;
    void *aboutObjectAddress;
    NSDate *dateAndTime;
    enum LogModule logModule;
    enum LogLevel logLevel;
}

@property (retain) NSString *formattedMessage;
@property int line;
@property (retain) NSString *file;
@property (retain) NSString *method;
@property void *aboutObjectAddress;
@property (retain) NSDate *dateAndTime;
@property enum LogModule logModule;
@property enum LogLevel logLevel;

- (void)dumpToNSLog;

@end

@interface CIAPILogging : NSObject
{
@private    
    NSMutableArray *logEntries;
}

+(CIAPILogging*)logger;

- (void)logMessageAtLevel:(enum LogLevel)logLevel fromFile:(char*)file line:(int)line method:(char*)method module:(enum LogModule)module aboutObject:(id)obj message:(NSString*)messageFormat, ...;

- (NSArray*)getMessagesFromModules:(unsigned long)modules upToLevel:(enum LogLevel)level;
- (NSArray*)getMessagesAboutObject:(id)object upToLevel:(enum LogLevel)level;
- (void)dumpMessagesFromModules:(unsigned long)modules upToLevel:(enum LogLevel)level;
- (void)dumpMessagesAboutObject:(id)object upToLevel:(enum LogLevel)level;

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

#else

#define CIAPILog(message, ...)
#define CIAPILogFromModule(module, message, ...)
#define CIAPILogAbout(module, obj, message, ...)

#endif