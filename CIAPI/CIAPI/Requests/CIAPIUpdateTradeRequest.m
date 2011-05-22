//
//  CIAPIUpdateTradeRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateTradeRequest.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize OrderId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"OrderId", OrderId, nil];
}

- (NSString*)urlTemplate
{
    return @"order/updatetradeorder";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

