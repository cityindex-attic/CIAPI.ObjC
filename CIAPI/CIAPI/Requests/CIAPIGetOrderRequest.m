//
//  CIAPIGetOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetOrderRequest.h"
#import "CIAPIGetOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize orderId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"orderId", orderId, nil];
}

- (NSString*)urlTemplate
{
    return @"order/{orderId}";
}

- (Class)responseClass
{
    return [CIAPIGetOrderResponse class];
}

@end

