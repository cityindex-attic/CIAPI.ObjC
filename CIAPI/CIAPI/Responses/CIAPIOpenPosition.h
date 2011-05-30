//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIBasicStopLimitOrder.h"
#import "CIAPIBasicStopLimitOrder.h"


@interface CIAPIOpenPosition : CIAPIObjectResponse {
  NSInteger OrderId;
  NSInteger MarketId;
  NSString* MarketName;
  NSString* Direction;
  double Quantity;
  double Price;
  NSInteger TradingAccountId;
  NSString* Currency;
  NSInteger Status;
  CIAPIBasicStopLimitOrder* StopOrder;
  CIAPIBasicStopLimitOrder* LimitOrder;
  NSString* LastChangedDateTimeUTC;
}

// The order's unique identifier. 
@property (readonly) NSInteger OrderId;
// The markets unique identifier. 
@property (readonly) NSInteger MarketId;
// The market's name. 
@property (readonly) NSString* MarketName;
// The direction, buy or sell. 
@property (readonly) NSString* Direction;
// The quantity of the order. 
@property (readonly) double Quantity;
// The price / rate that the trade was opened at. 
@property (readonly) double Price;
// The trading account that the order is on. 
@property (readonly) NSInteger TradingAccountId;
// The trade currency. 
@property (readonly) NSString* Currency;
// The order status. 
@property (readonly) NSInteger Status;
// The stop order attached to this order. 
@property (readonly) CIAPIBasicStopLimitOrder* StopOrder;
// The limit order attached to this order. 
@property (readonly) CIAPIBasicStopLimitOrder* LimitOrder;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) NSString* LastChangedDateTimeUTC;

@end
