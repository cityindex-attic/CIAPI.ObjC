//
//  CIAPIGetPriceBarsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceBarsRequest.h"

#import "CIAPIGetPriceBarResponse.h"

@implementation CIAPIGetPriceBarsRequest

@synthesize marketId;
@synthesize interval;
@synthesize span;
@synthesize priceBars;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/barhistory?interval={interval}&span={span}&pricebars={priceBars}";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIGetPriceBarResponse class];
}

@end

