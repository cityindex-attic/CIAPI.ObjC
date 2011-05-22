//
//  CIAPIGetOpenPositionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetOpenPositionRequest.h"
#import "CIAPIGetOpenPositionResponse.h"

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
    return @"order/{orderId}/openposition";
}

- (Class)responseClass
{
    return [CIAPIGetOpenPositionResponse class];
}

@end

