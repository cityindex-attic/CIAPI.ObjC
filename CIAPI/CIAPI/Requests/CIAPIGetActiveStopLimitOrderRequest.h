//
//  CIAPIGetActiveStopLimitOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for a active stop limit order with a specified order id. It will r
// eturn a null value if the order doesn't exist, or is not an active stop limit
//  order.<p> <p>This uri is intended to be used to support a grid in a UI. One 
// usage pattern is to subscribe to streaming orders, call <a onclick="dojo.hash
// ('#service.ListActiveStopLimitOrders'); return false;" class="json-link" href
// ="#">ListActiveStopLimitOrders</a> for the initial data to display in the gri
// d, and call this uri when you get updates on the order stream to get the upda
// ted data in this format.</p> <p>For a more comprehensive order response, see 
// <a onclick="dojo.hash('#service.GetOrder'); return false;" class="json-link" 
// href="#">GetOrder</a><p>
 
@interface CIAPIGetActiveStopLimitOrderRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* orderId;
}

// Properties for each field
// The requested order id. 
@property (retain) NSString* orderId;

// Constructor for the object
- (CIAPIGetActiveStopLimitOrderRequest*)initWithOrderId:(NSString*)_orderId;


@end

