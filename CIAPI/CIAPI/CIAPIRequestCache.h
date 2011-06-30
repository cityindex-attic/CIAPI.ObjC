//
//  CIAPIRequestCache.h
//  CIAPI
//
//  Created by Adam Wright on 30/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"
#import "CIAPIObjectResponse.h"

@interface CIAPIRequestCacheEntry : NSObject
{
    NSDate *createdTime;
    CIAPIObjectResponse *response;
    
    NSTimeInterval cacheDuration;
}

@property (readonly) NSDate *createdTime;
@property (readonly) CIAPIObjectResponse *response;

+ (CIAPIRequestCacheEntry*)requestCacheEntryForRequest:(CIAPIObjectRequest*)request response:(CIAPIObjectResponse*)_response;

- (BOOL)hasExpired;

@end

@interface CIAPIRequestCache : NSObject
{
    NSMutableDictionary *cacheDictionary;
}

- (BOOL)hasCachedResponseForRequest:(CIAPIObjectRequest*)request;
- (CIAPIObjectResponse*)cachedResponseForRequest:(CIAPIObjectRequest*)request;
- (void)cacheResponse:(CIAPIObjectResponse*)response forRequest:(CIAPIObjectRequest*)request;

@end

@interface CIAPIRequestCache ()

- (void)_purgeExpiredEntries;

@end