//
//  CIAPIGetOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for an order by a specific order id.</p> <p>The current implementa
// tion only returns active orders (i.e. those with a status of <b>1 - Pending, 
// 2 - Accepted, 3 - Open, 6 - Suspended, 8 - Yellow Card, 11 - Triggered)</b>.<
// /p>
 
@interface CIAPIGetOrderRequest : CIAPIObjectRequest {
 NSString* orderId;
}

// The requested order id. 
@property (retain) NSString* orderId;

@end
