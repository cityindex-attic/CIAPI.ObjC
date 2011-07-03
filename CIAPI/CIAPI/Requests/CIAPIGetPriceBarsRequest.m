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



- (CIAPIGetPriceBarsRequest*)initWithMarketId:(NSString*)_marketId interval:(NSString*)_interval span:(NSInteger)_span priceBars:(NSString*)_priceBars{
  self = [super init];

  if (self)
  {
    self.marketId = _marketId;
    self.interval = _interval;
    self.span = _span;
    self.priceBars = _priceBars;
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
    return @"market/{marketId}/barhistory?interval={interval}&span={span}&pricebars={priceBars}";
}

- (Class)responseClass
{
    return [CIAPIGetPriceBarResponse class];
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

