//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPITradeOrder.h"
#import "CIAPIStopLimitOrder.h"


@interface CIAPIGetOrderResponse : CIAPIObjectResponse {
  CIAPITradeOrder* TradeOrder;
  CIAPIStopLimitOrder* StopLimitOrder;
}

// The details of the order if it's a trade / open position. 
@property (readonly) CIAPITradeOrder* TradeOrder;
// The details of the order if it's a stop limit order. 
@property (readonly) CIAPIStopLimitOrder* StopLimitOrder;

@end
