//
//  CIAPIListActiveStopLimitOrdersRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListActiveStopLimitOrdersRequest.h"

#import "CIAPIListActiveStopLimitOrderResponse.h"

@implementation CIAPIListActiveStopLimitOrdersRequest

@synthesize tradingAccountId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/order/activestoplimitorders?TradingAccountId=(tradingAccountId)";
}

- (Class)responseClass
{
    return [CIAPIListActiveStopLimitOrderResponse class];
}

@end

