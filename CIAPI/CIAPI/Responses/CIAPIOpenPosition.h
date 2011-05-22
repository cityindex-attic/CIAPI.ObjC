//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIOpenPosition : NSObject {
  id OrderId;
  id MarketId;
  id MarketName;
  id Direction;
  id Quantity;
  id Price;
  id TradingAccountId;
  id Currency;
  id Status;
  id StopOrder;
  id LimitOrder;
  id LastChangedDateTimeUTC;
}

// The order's unique identifier. 
@property (readonly) id OrderId;
// The markets unique identifier. 
@property (readonly) id MarketId;
// The market's name. 
@property (readonly) id MarketName;
// The direction, buy or sell. 
@property (readonly) id Direction;
// The quantity of the order. 
@property (readonly) id Quantity;
// The price / rate that the trade was opened at. 
@property (readonly) id Price;
// The trading account that the order is on. 
@property (readonly) id TradingAccountId;
// The trade currency. 
@property (readonly) id Currency;
// The order status. 
@property (readonly) id Status;
// The stop order attached to this order. 
@property (readonly) id StopOrder;
// The limit order attached to this order. 
@property (readonly) id LimitOrder;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) id LastChangedDateTimeUTC;

@end
