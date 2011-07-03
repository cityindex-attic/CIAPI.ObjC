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



- (CIAPIListMarketInformationRequest*)initWithMarketIds:(NSArray*)_MarketIds{
  self = [super init];

  if (self)
  {
    self.MarketIds = _MarketIds;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction
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

- (Class)responseClass
{
    return [CIAPIListMarketInformationResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

