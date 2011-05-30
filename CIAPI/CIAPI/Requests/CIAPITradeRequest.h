//
//  CIAPITradeRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Place a trade on a particular market. Post a <a onclick="dojo.hash('#type.
// NewTradeOrderRequestDTO'); return false;" class="json-link" href="#">NewTrade
// OrderRequestDTO</a> to the uri specified below.</p> <p>Do not set any order i
// d fields when requesting a new trade, the platform will generate them.</p>
 
@interface CIAPITradeRequest : CIAPIObjectRequest {
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
@property  NSInteger MarketId;
// Currency to place order in 
@property (retain) NSString* Currency;
// Flag to indicate whether the trade will automatically roll into the             next market when the current market expires 
@property  BOOL AutoRollover;
// Direction identifier for order/trade, values supported are buy or sell 
@property (retain) NSString* Direction;
// Size of the order/trade 
@property  double Quantity;
// Quote Id 
@property (retain) NSString* QuoteId;
// Market prices are quoted as a pair (buy/sell or bid/offer),             the BidPrice is the lower of the two 
@property  double BidPrice;
// Market prices are quote as a pair (buy/sell or bid/offer),            the OfferPrice is the higher of the market price pair 
@property  double OfferPrice;
// Unique identifier for a price tick 
@property (retain) NSString* AuditId;
// TradingAccount associated with the trade/order request 
@property  NSInteger TradingAccountId;
// List of IfDone Orders which will be filled when            the initial trade/order is triggered 
@property (retain) NSArray* IfDone;
// List of existing order id's that require part            or full closure 
@property (retain) NSArray* Close;

@end
