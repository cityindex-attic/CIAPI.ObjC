//
//  CIAPIGetMarketInformationRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetMarketInformationRequest.h"

#import "CIAPIGetMarketInformationResponse.h"

@implementation CIAPIGetMarketInformationRequest

@synthesize marketId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/information";
}

- (Class)responseClass
{
    return [CIAPIGetMarketInformationResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

