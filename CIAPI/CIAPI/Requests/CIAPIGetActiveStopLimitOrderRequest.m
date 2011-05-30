//
//  CIAPIGetActiveStopLimitOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetActiveStopLimitOrderRequest.h"

#import "CIAPIGetActiveStopLimitOrderResponse.h"

@implementation CIAPIGetActiveStopLimitOrderRequest

@synthesize orderId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/(orderId)/activestoplimitorder";
}

- (Class)responseClass
{
    return [CIAPIGetActiveStopLimitOrderResponse class];
}

@end

