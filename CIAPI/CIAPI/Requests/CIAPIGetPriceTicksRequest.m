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



- (CIAPIGetPriceTicksRequest*)initWithMarketId:(NSString*)_marketId priceTicks:(NSString*)_priceTicks{
  self = [super init];

  if (self)
  {
    self.marketId = _marketId;
    self.priceTicks = _priceTicks;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"market/{marketId}/tickhistory?priceticks={priceTicks}";
}

- (Class)responseClass
{
    return [CIAPIGetPriceTickResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}

- (NSTimeInterval)cacheDuration
{
  return 10.0;
}

@end

