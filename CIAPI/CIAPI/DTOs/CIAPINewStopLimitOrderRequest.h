// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//A request for a stop/limit order
@interface CIAPINewStopLimitOrderRequest : NSObject 
{
  int TradingAccountId;
  NSString *Direction;
  int MarketId;
  NSString *ExpiryDateTimeUTC;
  NSString *AuditId;
  NSNumber *Quantity;
  NSNumber *BidPrice;
  NSNumber *OfferPrice;
  NSString *Applicability;
}

// TradingAccount associated with the trade/order request
@property int TradingAccountId;

// Direction identifier for order/trade, values supported are buy or sell
@property (retain) NSString *Direction;

// A market's unique identifier
@property int MarketId;

// The associated expiry DateTime for a pair of GoodTillDate IfDone orders
@property (retain) NSString *ExpiryDateTimeUTC;

// Unique identifier for a price tick
@property (retain) NSString *AuditId;

// Size of the order/trade
@property (retain) NSNumber *Quantity;

// Market prices are quoted as a pair (buy/sell or bid/offer), the BidPrice is the lower of the two
@property (retain) NSNumber *BidPrice;

// Market prices are quote as a pair (buy/sell or bid/offer), the OfferPrice is the higher of the market price pair
@property (retain) NSNumber *OfferPrice;

// Identifier which relates to the expiry of the order/trade, i.e. GoodTillDate (GTD), GoodTillCancelled (GTC) or GoodForDay (GFD)
@property (retain) NSString *Applicability;

@end

