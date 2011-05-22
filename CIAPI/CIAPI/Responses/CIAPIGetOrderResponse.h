//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetOrderResponse : CIAPIObjectResponse {
  id TradeOrder;
  id StopLimitOrder;
}

// The details of the order if it's a trade / open position. 
@property (readonly) id TradeOrder;
// The details of the order if it's a stop limit order. 
@property (readonly) id StopLimitOrder;

@end
