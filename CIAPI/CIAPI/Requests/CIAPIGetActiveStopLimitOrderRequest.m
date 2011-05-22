//
//  CIAPIGetActiveStopLimitOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetActiveStopLimitOrderRequest.h"
#import "CIAPIGetActiveStopLimitOrderResponse.h"

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
    return @"order/{orderId}/activestoplimitorder";
}

- (Class)responseClass
{
    return [CIAPIGetActiveStopLimitOrderResponse class];
}

@end

