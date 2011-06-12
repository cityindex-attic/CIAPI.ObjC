//
//  CIAPIGetPriceTicksRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceTicksRequest.h"

#import "CIAPIGetPriceTickResponse.h"

@implementation CIAPIGetPriceTicksRequest

@synthesize marketId;
@synthesize priceTicks;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/tickhistory?priceticks={priceTicks}";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIGetPriceTickResponse class];
}

@end

