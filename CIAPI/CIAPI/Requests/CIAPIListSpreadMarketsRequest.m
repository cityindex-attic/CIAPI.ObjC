//
//  CIAPIListSpreadMarketsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListSpreadMarketsRequest.h"

#import "CIAPIListSpreadMarketsResponse.h"

@implementation CIAPIListSpreadMarketsRequest

@synthesize searchByMarketName;
@synthesize searchByMarketCode;
@synthesize clientAccountId;
@synthesize maxResults;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"spread/markets?MarketName=(searchByMarketName)&MarketCode=(searchByMarketCode)&ClientAccountId=(clientAccountId)&MaxResults=(maxResults)";
}

- (Class)responseClass
{
    return [CIAPIListSpreadMarketsResponse class];
}

@end

