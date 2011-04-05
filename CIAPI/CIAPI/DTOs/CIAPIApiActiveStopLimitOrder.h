// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPIApiBasicStopLimitOrder.h"
#import "CIAPIApiBasicStopLimitOrder.h"
#import "CIAPIApiBasicStopLimitOrder.h"

//TODO
@interface CIAPIApiActiveStopLimitOrder : NSObject 
{
  NSString *LastChangedDateTimeUTC;
  NSString *Status;
  NSNumber *TradingAccountId;
  NSString *Direction;
  int MarketId;
  NSNumber *Quantity;
  CIAPIApiBasicStopLimitOrder *StopOrder;
  NSString *Applicability;
  NSString *Currency;
  NSString *MarketName;
  int OrderId;
  CIAPIApiBasicStopLimitOrder *OcoOrder;
  CIAPIApiBasicStopLimitOrder *LimitOrder;
  NSString *Type;
  NSNumber *TriggerPrice;
}

// TODO
@property (retain) NSString *LastChangedDateTimeUTC;

// TODO
@property (retain) NSString *Status;

// TODO
@property (retain) NSNumber *TradingAccountId;

// The direction, buy or sell.
@property (retain) NSString *Direction;

// The markets unique identifier.
@property int MarketId;

// TODO
@property (retain) NSNumber *Quantity;

// TODO
@property (retain) CIAPIApiBasicStopLimitOrder *StopOrder;

// TODO
@property (retain) NSString *Applicability;

// TODO
@property (retain) NSString *Currency;

// The market's name.
@property (retain) NSString *MarketName;

// The order's unique identifier.
@property int OrderId;

// TODO
@property (retain) CIAPIApiBasicStopLimitOrder *OcoOrder;

// TODO
@property (retain) CIAPIApiBasicStopLimitOrder *LimitOrder;

// TODO
@property (retain) NSString *Type;

// TODO
@property (retain) NSNumber *TriggerPrice;

@end

