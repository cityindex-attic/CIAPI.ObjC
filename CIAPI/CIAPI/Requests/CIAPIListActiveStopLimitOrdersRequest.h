//
//  CIAPIListActiveStopLimitOrdersRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for a specified trading account's active stop / limit orders.</p> 
// <p>This uri is intended to be used to support a grid in a UI. One usage patte
// rn is to subscribe to streaming orders, call this for the initial data to dis
// play in the grid, and call <a onclick="dojo.hash('#service.GetActiveStopLimit
// Order'); return false;" class="json-link" href="#">GetActiveStopLimitOrder</a
// > when you get updates on the order stream to get the updated data in this fo
// rmat.</p>
 
@interface CIAPIListActiveStopLimitOrdersRequest : CIAPIObjectRequest {
 NSInteger tradingAccountId;
}

// The trading account to get orders for. 
@property  NSInteger tradingAccountId;

@end
