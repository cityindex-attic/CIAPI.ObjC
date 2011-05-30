//
//  CIAPIOrderResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIOrderResponse.h"


@interface CIAPIOrderResponse : CIAPIObjectResponse {
  NSInteger OrderId;
  NSInteger StatusReason;
  NSInteger Status;
  double Price;
  double CommissionCharge;
  NSArray* IfDone;
  double GuaranteedPremium;
  CIAPIOrderResponse* OCO;
}

// order id. 
@property (readonly) NSInteger OrderId;
// order status reason id. 
@property (readonly) NSInteger StatusReason;
// order status id. 
@property (readonly) NSInteger Status;
// price. 
@property (readonly) double Price;
// commission charge. 
@property (readonly) double CommissionCharge;
// list of if done orders. 
@property (readonly) NSArray* IfDone;
// premium for guaranteed orders. 
@property (readonly) double GuaranteedPremium;
// an order in an OCO relationship with this order. 
@property (readonly) CIAPIOrderResponse* OCO;

@end
