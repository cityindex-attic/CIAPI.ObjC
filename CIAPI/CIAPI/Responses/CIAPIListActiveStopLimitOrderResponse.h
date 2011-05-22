//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListActiveStopLimitOrderResponse : CIAPIObjectListResponse {
  id ActiveStopLimitOrders;
}

// The requested list of active stop / limit orders. 
@property (readonly) id ActiveStopLimitOrders;

@end
