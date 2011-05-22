//
//  CIAPIListMarketInformationRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationRequest.h"
#import "CIAPIListMarketInformationResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize MarketIds;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"MarketIds", MarketIds, nil];
}

- (NSString*)urlTemplate
{
    return @"market/market/information";
}

- (Class)responseClass
{
    return [CIAPIListMarketInformationResponse class];
}

@end

