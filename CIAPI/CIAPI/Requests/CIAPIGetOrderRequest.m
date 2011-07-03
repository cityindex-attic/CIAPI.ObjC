//
//  CIAPIGetOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetOrderRequest.h"

#import "CIAPIGetOrderResponse.h"

@implementation CIAPIGetOrderRequest

@synthesize orderId;



- (CIAPIGetOrderRequest*)initWithOrderId:(NSString*)_orderId{
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
    return @"order/{orderId}";
}

- (Class)responseClass
{
    return [CIAPIGetOrderResponse class];
}



@end

