//
//  CIAPIRequestCache.m
//  CIAPI
//
//  Created by Adam Wright on 30/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIRequestCache.h"

@implementation CIAPIRequestCacheEntry

@synthesize createdTime;
@synthesize response;

+ (CIAPIRequestCacheEntry*)requestCacheEntryForRequest:(CIAPIObjectRequest*)request response:(CIAPIObjectResponse*)_response
{
    CIAPIRequestCacheEntry *entry = [[[CIAPIRequestCacheEntry alloc] init] autorelease];
    
    entry->createdTime = [NSDate date];
    entry->response = [_response retain];
    entry->cacheDuration = [request cacheDuration];
    
    return entry;
}

- (void)dealloc
{
    [response release];
    
    [super dealloc];
}

- (BOOL)hasExpired
{
    return (([self.createdTime timeIntervalSinceNow] + cacheDuration) < 0.0);
}

@end

@implementation CIAPIRequestCache

- (id)init
{
    self = [super init];
    
    if (self)
    {
        cacheDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    @synchronized (cacheDictionary)
    {
        [cacheDictionary release];
    }
}

- (BOOL)hasCachedResponseForRequest:(CIAPIObjectRequest*)request
{
    // We only purge in the check, so that "Check, then get" code won't think there's one, then fail to get it if swapped out long enough
    [self _purgeExpiredEntries];
    
    @synchronized (cacheDictionary)
    {
        return ([cacheDictionary objectForKey:request] != nil);
    }
}

- (CIAPIObjectResponse*)cachedResponseForRequest:(CIAPIObjectRequest*)request
{
    @synchronized (cacheDictionary)
    {
        return (CIAPIObjectResponse*)[[cacheDictionary objectForKey:request] response];
    }
}

- (void)cacheResponse:(CIAPIObjectResponse*)response forRequest:(CIAPIObjectRequest*)request
{
    NSAssert(![self hasCachedResponseForRequest:request], @"Cannot cache the same request twice!");
    
    CIAPIRequestCacheEntry *entry = [CIAPIRequestCacheEntry requestCacheEntryForRequest:request response:response];
    
    @synchronized (cacheDictionary)
    {
        [cacheDictionary setObject:entry forKey:request];
    }
}

- (void)_purgeExpiredEntries
{
    NSMutableArray *expiredKeys = [NSMutableArray array];
    
    @synchronized (cacheDictionary)
    {
        for (CIAPIObjectRequest *key in cacheDictionary)
        {
            if ([[cacheDictionary objectForKey:key] hasExpired])
                [expiredKeys addObject:key];
        }
        
        [cacheDictionary removeObjectsForKeys:expiredKeys];
    }
}

@end
