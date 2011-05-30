//
//  CIAPINewTradeOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPINewTradeOrderRequest : CIAPIObjectResponse {
  NSInteger MarketId;
  NSString* Currency;
  BOOL AutoRollover;
  NSString* Direction;
  double Quantity;
  NSString* QuoteId;
  double BidPrice;
  double OfferPrice;
  NSString* AuditId;
  NSInteger TradingAccountId;
  NSArray* IfDone;
  NSArray* Close;
}

// A market's unique identifier 
@property (readonly) NSInteger MarketId;
// Currency to place order in 
@property (readonly) NSString* Currency;
// Flag to indicate whether the trade will automatically roll into the next market when the current market expires 
@property (readonly) BOOL AutoRollover;
// Direction identifier for order/trade, values supported are buy or sell 
@property (readonly) NSString* Direction;
// Size of the order/trade 
@property (readonly) double Quantity;
// Quote Id 
@property (readonly) NSString* QuoteId;
// Market prices are quoted as a pair (buy/sell or bid/offer), the BidPrice is the lower of the two 
@property (readonly) double BidPrice;
// Market prices are quote as a pair (buy/sell or bid/offer), the OfferPrice is the higher of the market price pair 
@property (readonly) double OfferPrice;
// Unique identifier for a price tick 
@property (readonly) NSString* AuditId;
// TradingAccount associated with the trade/order request 
@property (readonly) NSInteger TradingAccountId;
// List of IfDone Orders which will be filled when the initial trade/order is triggered 
@property (readonly) NSArray* IfDone;
// List of existing order id's that require part or full closure 
@property (readonly) NSArray* Close;

@end
