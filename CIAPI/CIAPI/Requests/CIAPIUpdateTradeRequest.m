//
//  CIAPIUpdateTradeRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateTradeRequest.h"

#import "CIAPITradeOrderResponse.h"

@implementation CIAPIUpdateTradeRequest

@synthesize OrderId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"order/updatetradeorder";
}

- (NSString*)throttleScope
{
    return @"trading";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

