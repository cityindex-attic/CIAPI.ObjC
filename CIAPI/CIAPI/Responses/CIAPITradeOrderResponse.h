//
//  CIAPITradeOrderResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIQuoteResponse.h"


@interface CIAPITradeOrderResponse : CIAPIObjectResponse {
  NSInteger Status;
  NSInteger StatusReason;
  NSInteger OrderId;
  NSArray* Orders;
  CIAPIQuoteResponse* Quote;
}

// The status of the order (Pending, Accepted, Open, etc) 
@property (readonly) NSInteger Status;
// The id corresponding to a more descriptive reason for the order status 
@property (readonly) NSInteger StatusReason;
// The unique identifier associated to the order returned from the underlying trading system 
@property (readonly) NSInteger OrderId;
// List of orders with their associated response 
@property (readonly) NSArray* Orders;
// Quote response 
@property (readonly) CIAPIQuoteResponse* Quote;

@end
