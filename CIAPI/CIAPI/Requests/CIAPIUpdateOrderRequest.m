//
//  CIAPIUpdateOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateOrderRequest.h"

#import "CIAPITradeOrderResponse.h"

@implementation CIAPIUpdateOrderRequest




// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
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

