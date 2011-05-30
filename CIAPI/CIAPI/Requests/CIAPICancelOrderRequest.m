//
//  CIAPICancelOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPICancelOrderRequest.h"

#import "CIAPITradeOrderResponse.h"

@implementation CIAPICancelOrderRequest

@synthesize OrderId;
@synthesize TradingAccountId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"order/cancel";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

