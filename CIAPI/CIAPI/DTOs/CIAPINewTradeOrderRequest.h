// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//A request for a trade order
@interface CIAPINewTradeOrderRequest : NSObject 
{
  int TradingAccountId;
  NSString *Direction;
  int MarketId;
  NSString *AuditId;
  NSNumber *Quantity;
  NSNumber *BidPrice;
  NSNumber *OfferPrice;
}

// TradingAccount associated with the trade/order request
@property int TradingAccountId;

// Direction identifier for order/trade, values supported are buy or sell
@property (retain) NSString *Direction;

// A market's unique identifier
@property int MarketId;

// Unique identifier for a price tick
@property (retain) NSString *AuditId;

// Size of the order/trade
@property (retain) NSNumber *Quantity;

// Market prices are quoted as a pair (buy/sell or bid/offer), the BidPrice is the lower of the two
@property (retain) NSNumber *BidPrice;

// Market prices are quote as a pair (buy/sell or bid/offer), the OfferPrice is the higher of the market price pair
@property (retain) NSNumber *OfferPrice;

@end

