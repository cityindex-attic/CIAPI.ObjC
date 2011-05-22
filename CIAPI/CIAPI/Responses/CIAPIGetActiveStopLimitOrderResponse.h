//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetActiveStopLimitOrderResponse : CIAPIObjectResponse {
  id ActiveStopLimitOrder;
}

// The active stop limit order. If it is null then the active stop limit order does not exist. 
@property (readonly) id ActiveStopLimitOrder;

@end
