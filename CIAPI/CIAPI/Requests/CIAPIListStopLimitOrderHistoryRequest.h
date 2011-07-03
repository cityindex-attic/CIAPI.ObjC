//
//  CIAPIListStopLimitOrderHistoryRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for a specified trading account's stop / limit order history. The 
// result set will include <b>only orders that were originally stop / limit orde
// rs</b> that currently have one of the following statuses <b>(3 - Open, 4 - Ca
// ncelled, 5 - Rejected, 9 - Closed, 10 - Red Card)</b> </p> <p>There's current
// ly no corresponding GetStopLimitOrderHistory (as with ListActiveStopLimitOrde
// rs).</p>
 
@interface CIAPIListStopLimitOrderHistoryRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSInteger tradingAccountId;
  NSInteger maxResults;
}

// Properties for each field
// The trading account to get orders for. 
@property  NSInteger tradingAccountId;
// the maximum results to return. 
@property  NSInteger maxResults;

// Constructor for the object
- (CIAPIListStopLimitOrderHistoryRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId maxResults:(NSInteger)_maxResults;


@end

