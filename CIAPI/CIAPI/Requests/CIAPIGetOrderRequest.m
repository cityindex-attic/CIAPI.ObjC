//
//  CIAPIGetOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetOrderRequest.h"

#import "CIAPIGetOrderResponse.h"

@implementation CIAPIGetOrderRequest

@synthesize orderId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/(orderId)";
}

- (Class)responseClass
{
    return [CIAPIGetOrderResponse class];
}

@end

