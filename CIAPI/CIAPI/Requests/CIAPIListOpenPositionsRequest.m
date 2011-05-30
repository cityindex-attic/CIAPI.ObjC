//
//  CIAPIListOpenPositionsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListOpenPositionsRequest.h"

#import "CIAPIListOpenPositionsResponse.h"

@implementation CIAPIListOpenPositionsRequest

@synthesize tradingAccountId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/order/openpositions?TradingAccountId=(tradingAccountId)";
}

- (Class)responseClass
{
    return [CIAPIListOpenPositionsResponse class];
}

@end

