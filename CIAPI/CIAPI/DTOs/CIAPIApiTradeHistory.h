// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//TODO
@interface CIAPIApiTradeHistory : NSObject<RKObjectMappable> 
{
  NSString *LastChangedDateTimeUtc;
  int TradingAccountId;
  NSString *Direction;
  int MarketId;
  NSNumber *OriginalQuantity;
  NSString *Currency;
  NSNumber *Price;
  NSString *MarketName;
  int OrderId;
}

// TODO
@property (retain) NSString *LastChangedDateTimeUtc;

// TODO
@property int TradingAccountId;

// TODO
@property (retain) NSString *Direction;

// TODO
@property int MarketId;

// TODO
@property (retain) NSNumber *OriginalQuantity;

// The trade currency
@property (retain) NSString *Currency;

// TODO
@property (retain) NSNumber *Price;

// TODO
@property (retain) NSString *MarketName;

// TODO
@property int OrderId;

@end

