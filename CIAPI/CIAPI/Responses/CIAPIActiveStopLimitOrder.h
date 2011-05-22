//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIActiveStopLimitOrder : NSObject {
  id OrderId;
  id ParentOrderId;
  id MarketId;
  id MarketName;
  id Direction;
  id Quantity;
  id TriggerPrice;
  id TradingAccountId;
  id Type;
  id Applicability;
  id ExpiryDateTimeUTC;
  id Currency;
  id Status;
  id StopOrder;
  id LimitOrder;
  id OcoOrder;
  id LastChangedDateTimeUTC;
}

// The order's unique identifier. 
@property (readonly) id OrderId;
// The order's parent OrderId. 
@property (readonly) id ParentOrderId;
// The markets unique identifier. 
@property (readonly) id MarketId;
// The market's name. 
@property (readonly) id MarketName;
// The direction, buy or sell. 
@property (readonly) id Direction;
// The quantity of the product. 
@property (readonly) id Quantity;
// The marked to market price at which the order will trigger at. 
@property (readonly) id TriggerPrice;
// The trading account that the order is on. 
@property (readonly) id TradingAccountId;
// The type of order, i.e. stop or limit. 
@property (readonly) id Type;
// When the order applies until. i.e. good till cancelled (GTC) good for day (GFD) or good till time (GTT). 
@property (readonly) id Applicability;
// The associated expiry DateTime. 
@property (readonly) id ExpiryDateTimeUTC;
// The trade currency. 
@property (readonly) id Currency;
// The order status. 
@property (readonly) id Status;
// The if done stop order. 
@property (readonly) id StopOrder;
// The if done limit order 
@property (readonly) id LimitOrder;
// The order on the other side of a one Cancels the other relationship. 
@property (readonly) id OcoOrder;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) id LastChangedDateTimeUTC;

@end
