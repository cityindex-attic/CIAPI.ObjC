//
//  CIAPIListOpenPositionsRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

// <p>Queries for a specified trading account's trades / open positions.</p> <p>
// This uri is intended to be used to support a grid in a UI. One usage pattern 
// is to subscribe to streaming orders, call this for the initial data to displa
// y in the grid, and call <a onclick="dojo.hash('#service.GetOpenPosition'); re
// turn false;" class="json-link" href="#">GetOpenPosition</a> when you get upda
// tes on the order stream to get the updated data in this format.</p>
 
@interface CIAPIListOpenPositionsRequest : CIAPIObjectRequest {
  id tradingAccountId;
}

  // The trading account to get orders for. 
  @property (retain) id tradingAccountId;

@end
