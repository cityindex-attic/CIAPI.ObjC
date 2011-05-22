//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIOrderResponse : CIAPIObjectResponse {
  id OrderId;
  id StatusReason;
  id Status;
  id Price;
  id CommissionCharge;
  id IfDone;
  id GuaranteedPremium;
  id OCO;
}

// order id. 
@property (readonly) id OrderId;
// order status reason id. 
@property (readonly) id StatusReason;
// order status id. 
@property (readonly) id Status;
// price. 
@property (readonly) id Price;
// commission charge. 
@property (readonly) id CommissionCharge;
// list of if done orders. 
@property (readonly) id IfDone;
// premium for guaranteed orders. 
@property (readonly) id GuaranteedPremium;
// an order in an OCO relationship with this order. 
@property (readonly) id OCO;

@end
