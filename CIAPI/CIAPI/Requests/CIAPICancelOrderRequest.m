//
//  CIAPICancelOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPICancelOrderRequest.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize OrderId;
@synthesize TradingAccountId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"OrderId", OrderId,  @"TradingAccountId", TradingAccountId, nil];
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

