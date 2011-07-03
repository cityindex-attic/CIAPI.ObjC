//
//  CIAPICancelOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPICancelOrderRequest.h"

#import "CIAPITradeOrderResponse.h"

@implementation CIAPICancelOrderRequest

@synthesize OrderId;
@synthesize TradingAccountId;



- (CIAPICancelOrderRequest*)initWithOrderId:(NSInteger)_OrderId tradingAccountId:(NSInteger)_TradingAccountId{
  self = [super init];

  if (self)
  {
    self.OrderId = _OrderId;
    self.TradingAccountId = _TradingAccountId;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"order/cancel";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}



@end

