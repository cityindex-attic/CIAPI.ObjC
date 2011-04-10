// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "CIAPIApiBasicStopLimitOrder.h"
#import "CIAPIApiBasicStopLimitOrder.h"

//TODO
@interface CIAPIApiOpenPosition : NSObject<RKObjectMappable> 
{
  NSString *LastChangedDateTimeUTC;
  NSString *Status;
  int TradingAccountId;
  NSString *Direction;
  int MarketId;
  NSNumber *Quantity;
  CIAPIApiBasicStopLimitOrder *StopOrder;
  NSString *Currency;
  NSNumber *Price;
  NSString *MarketName;
  int OrderId;
  CIAPIApiBasicStopLimitOrder *LimitOrder;
}

// The date time the order was last changed.
@property (retain) NSString *LastChangedDateTimeUTC;

// The order status.
@property (retain) NSString *Status;

// The trading account that the order is on.
@property int TradingAccountId;

// The direction, buy or sell.
@property (retain) NSString *Direction;

// The markets unique identifier.
@property int MarketId;

// The quantity of the order.
@property (retain) NSNumber *Quantity;

// The stop order attached to this order.
@property (retain) CIAPIApiBasicStopLimitOrder *StopOrder;

// The trade currency.
@property (retain) NSString *Currency;

// The price / rate that the trade was opened at.
@property (retain) NSNumber *Price;

// The market's name.
@property (retain) NSString *MarketName;

// The order's unique identifier.
@property int OrderId;

// The limit order attached to this order.
@property (retain) CIAPIApiBasicStopLimitOrder *LimitOrder;

@end

