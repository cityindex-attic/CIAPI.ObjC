// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//An order for a specific Trading Account
@interface CIAPIOrder : NSObject<RKObjectMappable> 
{
  NSString *Status;
  NSNumber *OpenPrice;
  NSString *LastChangedTime;
  int Direction;
  int TradingAccountId;
  int CurrencyId;
  int MarketId;
  NSNumber *Quantity;
  BOOL AutoRollover;
  NSString *CurrencyISO;
  NSNumber *OriginalQuantity;
  NSNumber *ExecutionPrice;
  int ReasonId;
  int ClientAccountId;
  int OrderId;
  NSString *Type;
  NSString *OriginalLastChangedDateTime;
}

// ???
@property (retain) NSString *Status;

// ???
@property (retain) NSNumber *OpenPrice;

// The date of the Order. Always expressed in UTC
@property (retain) NSString *LastChangedTime;

// ???
@property int Direction;

// ???
@property int TradingAccountId;

// ???
@property int CurrencyId;

// ???
@property int MarketId;

// ???
@property (retain) NSNumber *Quantity;

// ???
@property BOOL AutoRollover;

// ???
@property (retain) NSString *CurrencyISO;

// ???
@property (retain) NSNumber *OriginalQuantity;

// ???
@property (retain) NSNumber *ExecutionPrice;

// ???
@property int ReasonId;

// ???
@property int ClientAccountId;

// ???
@property int OrderId;

// ???
@property (retain) NSString *Type;

// The date of the Order. Always expressed in UTC
@property (retain) NSString *OriginalLastChangedDateTime;

@end

