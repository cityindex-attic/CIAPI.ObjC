//
//  CIAPIGetOpenPositionRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for a trade / open position with a specified order id. It will ret
// urn a null value if the order doesn't exist, or is not a trade / open positio
// n.</p> <p>This uri is intended to be used to support a grid in a UI. One usag
// e pattern is to subscribe to streaming orders, call <a onclick="dojo.hash('#s
// ervice.ListOpenPositions'); return false;" class="json-link" href="#">ListOpe
// nPositions</a> for the initial data to display in the grid, and call this uri
//  when you get updates on the order stream to get the updated data in this for
// mat.</p> <p>For a more comprehensive order response, see <a onclick="dojo.has
// h('#service.GetOrder'); return false;" class="json-link" href="#">GetOrder</a
// ><p>
 
@interface CIAPIGetOpenPositionRequest : CIAPIObjectRequest {
 NSString* orderId;
}

// The requested order id. 
@property (retain) NSString* orderId;

@end
