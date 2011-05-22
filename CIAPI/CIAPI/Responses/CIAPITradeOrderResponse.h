//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPITradeOrderResponse : CIAPIObjectResponse {
  id Status;
  id StatusReason;
  id OrderId;
  id Orders;
  id Quote;
}

// The status of the order (Pending, Accepted, Open, etc) 
@property (readonly) id Status;
// The id corresponding to a more descriptive reason for the order status 
@property (readonly) id StatusReason;
// The unique identifier associated to the order returned from the underlying trading system 
@property (readonly) id OrderId;
// List of orders with their associated response 
@property (readonly) id Orders;
// Quote response 
@property (readonly) id Quote;

@end
