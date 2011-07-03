//
//  CIAPIListActiveStopLimitOrdersRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListActiveStopLimitOrdersRequest.h"

#import "CIAPIListActiveStopLimitOrderResponse.h"

@implementation CIAPIListActiveStopLimitOrdersRequest

@synthesize tradingAccountId;



- (CIAPIListActiveStopLimitOrdersRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId{
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
    return @"order/order/activestoplimitorders?TradingAccountId={tradingAccountId}";
}

- (Class)responseClass
{
    return [CIAPIListActiveStopLimitOrderResponse class];
}



@end

