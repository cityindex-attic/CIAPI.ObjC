//
//  CIAPIListActiveStopLimitOrdersRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListActiveStopLimitOrdersRequest.h"
#import "CIAPIListActiveStopLimitOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize tradingAccountId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"tradingAccountId", tradingAccountId, nil];
}

- (NSString*)urlTemplate
{
    return @"order/order/activestoplimitorders?TradingAccountId={tradingAccountId}";
}

- (Class)responseClass
{
    return [CIAPIListActiveStopLimitOrderResponse class];
}

@end

