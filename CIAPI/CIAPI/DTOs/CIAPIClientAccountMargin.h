// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//The current margin for a specific client account
@interface CIAPIClientAccountMargin : NSObject<RKObjectMappable> 
{
  NSNumber *OpenTradeEquity;
  int CurrencyId;
  NSNumber *PendingFunds;
  NSString *CurrencyISO;
  NSNumber *NetEquity;
  NSNumber *MarginIndicator;
  NSNumber *TradeableFunds;
  NSNumber *Margin;
  NSNumber *TotalMarginRequirement;
  NSNumber *TradingResource;
  NSNumber *Cash;
}

// ???
@property (retain) NSNumber *OpenTradeEquity;

// ???
@property int CurrencyId;

// ???
@property (retain) NSNumber *PendingFunds;

// ???
@property (retain) NSString *CurrencyISO;

// ???
@property (retain) NSNumber *NetEquity;

// ???
@property (retain) NSNumber *MarginIndicator;

// ???
@property (retain) NSNumber *TradeableFunds;

// ???
@property (retain) NSNumber *Margin;

// ???
@property (retain) NSNumber *TotalMarginRequirement;

// ???
@property (retain) NSNumber *TradingResource;

// ???
@property (retain) NSNumber *Cash;

@end

