//
//  CIAPIGetMarketInformationRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetMarketInformationRequest.h"
#import "CIAPIGetMarketInformationResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize marketId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"marketId", marketId, nil];
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/information";
}

- (Class)responseClass
{
    return [CIAPIGetMarketInformationResponse class];
}

@end

