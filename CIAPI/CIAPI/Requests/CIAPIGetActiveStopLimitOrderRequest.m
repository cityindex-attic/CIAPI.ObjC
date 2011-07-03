//
//  CIAPIGetActiveStopLimitOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetActiveStopLimitOrderRequest.h"

#import "CIAPIGetActiveStopLimitOrderResponse.h"

@implementation CIAPIGetActiveStopLimitOrderRequest

@synthesize orderId;



- (CIAPIGetActiveStopLimitOrderRequest*)initWithOrderId:(NSString*)_orderId{
  self = [super init];

  if (self)
  {
    self.orderId = _orderId;
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
    return @"order/{orderId}/activestoplimitorder";
}

- (Class)responseClass
{
    return [CIAPIGetActiveStopLimitOrderResponse class];
}



@end

