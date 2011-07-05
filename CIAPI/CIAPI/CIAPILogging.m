//
//  CIAPILogging.m
//  CIAPI
//
//  Created by Adam Wright on 27/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPILogging.h"

#ifdef DEBUG

static CIAPILogging *logSingleton = nil;

@implementation CIAPILogEntry

@synthesize formattedMessage;
@synthesize line;
@synthesize file;
@synthesize method;
@synthesize aboutObjectAddress;
@synthesize dateAndTime;
@synthesize logModule;
@synthesize logLevel;

- (CIAPILogEntry*)init
{
    self = [super init];
    
    if (self)        
    {
        dateAndTime = [[NSDate date] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [formattedMessage release];
    [file release];
    [method release];
    [dateAndTime release];
    
    [super dealloc];
}

- (void)dumpToNSLog
{
     NSLog(@"\"%@\" - %@ (%@):%d", formattedMessage, file, method, line);
}

@end

@implementation CIAPILogging

+(CIAPILogging*)logger
{
    if (!logSingleton)
        logSingleton = [[CIAPILogging alloc] init];
    
    return logSingleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        logEntries = [[NSMutableArray array] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [logEntries release];
    
    [super dealloc];
}

- (void)logMessageAtLevel:(enum CIAPILogLevel)level fromFile:(char*)file line:(int)line method:(char*)method module:(enum CIAPILogModule)module aboutObject:(id)obj message:(NSString*)messageFormat, ...
{
    va_list ap;
	va_start(ap, messageFormat);
	NSString *formattedMessage = [[NSString alloc] initWithFormat:messageFormat arguments:ap];
	va_end(ap);
    
    CIAPILogEntry *logEntry = [[CIAPILogEntry alloc] init];
    logEntry.file = [NSString stringWithCString:file encoding:NSASCIIStringEncoding];
    logEntry.line = line;
    logEntry.method = [NSString stringWithCString:method encoding:NSASCIIStringEncoding];
    logEntry.formattedMessage = formattedMessage;
    logEntry.aboutObjectAddress = (void*)obj;
    logEntry.logModule = module;
    logEntry.logLevel = level;
    
    @synchronized (logEntry)
    {
        [logEntries addObject:logEntry];
        
        if (CIAPI_LOGGING_ALSO_NS_LOG && logEntry.logLevel >= CIAPI_LOGGING_ALSO_NS_LOG_MIN_LEVEL)
            [logEntry dumpToNSLog];
    }

    [logEntry release];
    [formattedMessage release];
}

- (NSArray*)allMessages
{
    @synchronized (logEntries)
    {
        return [NSArray arrayWithArray:logEntries];
    }
}

- (NSArray*)getMessagesFromModules:(unsigned long)modules upToLevel:(enum CIAPILogLevel)level
{
    @synchronized (logEntries)
    {
        return [logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CIAPILogEntry *obj, NSDictionary *bindings)
                                                          {
                                                              return (((obj.logModule & modules) != 0) && obj.logLevel <= level);
                                                          }]];
    }
}

- (NSArray*)getMessagesAboutObject:(id)object upToLevel:(enum CIAPILogLevel)level
{
    @synchronized (logEntries)
    {
        return [logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CIAPILogEntry *obj, NSDictionary *bindings)
                                                    {
                                                        return (obj.aboutObjectAddress == (void*)object && obj.logLevel <= level);
                                                    }]];
    }
}

- (void)dumpMessagesFromModules:(unsigned long)modules upToLevel:(enum CIAPILogLevel)level
{
    [[self getMessagesFromModules:modules upToLevel:level] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj dumpToNSLog];
    }];
}

- (void)dumpMessagesAboutObject:(id)object upToLevel:(enum CIAPILogLevel)level
{
    [[self getMessagesAboutObject:object upToLevel:level] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj dumpToNSLog];
    }];    
}

@end

#endif