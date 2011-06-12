//
//  CIAPIListMarketInformationRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationRequest.h"

#import "CIAPIListMarketInformationResponse.h"

@implementation CIAPIListMarketInformationRequest

@synthesize MarketIds;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"MarketIds"]) return [NSNumber class];
  return nil;
}

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"market/market/information";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIListMarketInformationResponse class];
}

@end

