//
//  CIAPIListActiveStopLimitOrderResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListActiveStopLimitOrderResponse : CIAPIObjectListResponse {
  NSArray* ActiveStopLimitOrders;
}

// The requested list of active stop / limit orders. 
@property (readonly) NSArray* ActiveStopLimitOrders;

@end
