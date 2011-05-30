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
 NSInteger OrderId;
 NSInteger TradingAccountId;
}

// The order identifier. 
@property  NSInteger OrderId;
// TradingAccount associated with the cancel order request. 
@property  NSInteger TradingAccountId;

@end
