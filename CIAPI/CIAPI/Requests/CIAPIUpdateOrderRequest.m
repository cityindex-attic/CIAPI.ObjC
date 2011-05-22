//
//  CIAPIUpdateOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateOrderRequest.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects: nil];
}

- (NSString*)urlTemplate
{
    return @"order/updatestoplimitorder";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

