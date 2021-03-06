//
//  CIAPIListTradeHistoryRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for a specified trading account's trade history. The result set wi
// ll contain orders with a status of <b>(3 - Open, 9 - Closed)</b>, and include
// s <b>orders that were a trade / stop / limit order</b>.</p> <p>There's curren
// tly no corresponding GetTradeHistory (as with ListOpenPositions).</p>
 
@interface CIAPIListTradeHistoryRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSInteger tradingAccountId;
  NSInteger maxResults;
}

// Properties for each field
// The trading account to get orders for. 
@property  NSInteger tradingAccountId;
// The maximum results to return. 
@property  NSInteger maxResults;

// Constructor for the object
- (CIAPIListTradeHistoryRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId maxResults:(NSInteger)_maxResults;


@end

