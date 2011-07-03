//
//  CIAPICancelOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Cancel an order. Post a <a onclick="dojo.hash('#type.CancelOrderRequestDTO
// '); return false;" class="json-link" href="#">CancelOrderRequestDTO</a> to th
// e uri specified below</p>
 
@interface CIAPICancelOrderRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSInteger OrderId;
  NSInteger TradingAccountId;
}

// Properties for each field
// The order identifier. 
@property  NSInteger OrderId;
// TradingAccount associated with the cancel order request. 
@property  NSInteger TradingAccountId;

// Constructor for the object
- (CIAPICancelOrderRequest*)initWithOrderId:(NSInteger)_OrderId tradingAccountId:(NSInteger)_TradingAccountId;


@end

