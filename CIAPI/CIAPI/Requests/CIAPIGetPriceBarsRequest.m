//
//  CIAPIGetPriceBarsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceBarsRequest.h"
#import "CIAPIGetPriceBarResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize marketId;
@synthesize interval;
@synthesize span;
@synthesize priceBars;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"marketId", marketId,  @"interval", interval,  @"span", span,  @"priceBars", priceBars, nil];
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/barhistory?interval={interval}&span={span}&pricebars={priceBars}";
}

- (Class)responseClass
{
    return [CIAPIGetPriceBarResponse class];
}

@end

