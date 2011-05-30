//
//  CIAPIGetActiveStopLimitOrderResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIActiveStopLimitOrder.h"


@interface CIAPIGetActiveStopLimitOrderResponse : CIAPIObjectResponse {
  CIAPIActiveStopLimitOrder* ActiveStopLimitOrder;
}

// The active stop limit order. If it is null then the active stop limit order does not exist. 
@property (readonly) CIAPIActiveStopLimitOrder* ActiveStopLimitOrder;

@end
