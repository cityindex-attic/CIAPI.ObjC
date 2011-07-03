//
//  CIAPIListOpenPositionsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListOpenPositionsRequest.h"

#import "CIAPIListOpenPositionsResponse.h"

@implementation CIAPIListOpenPositionsRequest

@synthesize tradingAccountId;



- (CIAPIListOpenPositionsRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId{
  self = [super init];

  if (self)
  {
    self.tradingAccountId = _tradingAccountId;
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
    return @"order/order/openpositions?TradingAccountId={tradingAccountId}";
}

- (Class)responseClass
{
    return [CIAPIListOpenPositionsResponse class];
}



@end

