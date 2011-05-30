//
//  CIAPIListCfdMarketsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListCfdMarketsRequest.h"

#import "CIAPIListCfdMarketsResponse.h"

@implementation CIAPIListCfdMarketsRequest

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
    return @"cfd/markets?MarketName={searchByMarketName}&MarketCode={searchByMarketCode}&ClientAccountId={clientAccountId}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListCfdMarketsResponse class];
}

@end

