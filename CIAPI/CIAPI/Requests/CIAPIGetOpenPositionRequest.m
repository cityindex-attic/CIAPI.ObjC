//
//  CIAPIGetOpenPositionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetOpenPositionRequest.h"

#import "CIAPIGetOpenPositionResponse.h"

@implementation CIAPIGetOpenPositionRequest

@synthesize orderId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/(orderId)/openposition";
}

- (Class)responseClass
{
    return [CIAPIGetOpenPositionResponse class];
}

@end

