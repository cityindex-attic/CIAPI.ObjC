// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//TODO
@interface CIAPIApiStopLimitOrderHistory : NSObject<RKObjectMappable> 
{
  NSString *LastChangedDateTimeUtc;
  int OrderApplicabilityId;
  int TradingAccountId;
  NSString *Direction;
  int MarketId;
  int TypeId;
  int StatusId;
  NSNumber *OriginalQuantity;
  NSString *Currency;
  NSString *Price;
  NSString *MarketName;
  int OrderId;
  NSNumber *TriggerPrice;
}

// The date time the order was last changed.
@property (retain) NSString *LastChangedDateTimeUtc;

// When the order applies until. ie good till cancelled (GTC) good for day (GFD) or good till time (GTT).
@property int OrderApplicabilityId;

// The trading account that the order is on.
@property int TradingAccountId;

// The direction, buy or sell.
@property (retain) NSString *Direction;

// The markets unique identifier.
@property int MarketId;

// The type of the order stop, limit or trade
@property int TypeId;

// the order status.
@property int StatusId;

// The quantity of the order when it became a trade / was cancelled etc.
@property (retain) NSNumber *OriginalQuantity;

// The trade currency
@property (retain) NSString *Currency;

// The price / rate that the order was filled at.
@property (retain) NSString *Price;

// The market's name.
@property (retain) NSString *MarketName;

// The order's unique identifier.
@property int OrderId;

// The price / rate that the the order was set to trigger at.
@property (retain) NSNumber *TriggerPrice;

@end

