//
//  CIAPIUpdateTradeRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateTradeRequest.h"

#import "CIAPITradeOrderResponse.h"

@implementation CIAPIUpdateTradeRequest

@synthesize OrderId;



- (CIAPIUpdateTradeRequest*)initWithOrderId:(NSInteger)_OrderId{
  self = [super init];

  if (self)
  {
    self.OrderId = _OrderId;
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
    return @"order/updatetradeorder";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

- (NSString*)throttleScope
{
    return @"trading";
}


@end

