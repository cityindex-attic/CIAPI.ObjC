//
//  CIAPIGetPriceTicksRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceTicksRequest.h"
#import "CIAPIGetPriceTickResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize marketId;
@synthesize priceTicks;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"marketId", marketId,  @"priceTicks", priceTicks, nil];
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/tickhistory?priceticks={priceTicks}";
}

- (Class)responseClass
{
    return [CIAPIGetPriceTickResponse class];
}

@end

