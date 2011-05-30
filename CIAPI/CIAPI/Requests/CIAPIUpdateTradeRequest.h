//
//  CIAPIUpdateTradeRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Update a trade (for adding a stop/limit etc). Post an <a onclick="dojo.hash('
// #type.UpdateTradeOrderRequestDTO'); return false;" class="json-link" href="#"
// >UpdateTradeOrderRequestDTO</a> to the uri specified below</p>
 
@interface CIAPIUpdateTradeRequest : CIAPIObjectRequest {
 NSInteger OrderId;
}

// Order identifier of the order to update 
@property  NSInteger OrderId;

@end
