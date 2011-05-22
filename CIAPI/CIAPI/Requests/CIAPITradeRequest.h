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
  id MarketId;
  id Currency;
  id AutoRollover;
  id Direction;
  id Quantity;
  id QuoteId;
  id BidPrice;
  id OfferPrice;
  id AuditId;
  id TradingAccountId;
  id IfDone;
  id Close;
}

  // A market's unique identifier 
  @property (retain) id MarketId;
  // Currency to place order in 
  @property (retain) id Currency;
  // Flag to indicate whether the trade will automatically roll into the 
            next market when the current market expires 
  @property (retain) id AutoRollover;
  // Direction identifier for order/trade, values supported are buy or sell 
  @property (retain) id Direction;
  // Size of the order/trade 
  @property (retain) id Quantity;
  // Quote Id 
  @property (retain) id QuoteId;
  // Market prices are quoted as a pair (buy/sell or bid/offer), 
            the BidPrice is the lower of the two 
  @property (retain) id BidPrice;
  // Market prices are quote as a pair (buy/sell or bid/offer),
            the OfferPrice is the higher of the market price pair 
  @property (retain) id OfferPrice;
  // Unique identifier for a price tick 
  @property (retain) id AuditId;
  // TradingAccount associated with the trade/order request 
  @property (retain) id TradingAccountId;
  // List of IfDone Orders which will be filled when
            the initial trade/order is triggered 
  @property (retain) id IfDone;
  // List of existing order id's that require part
            or full closure 
  @property (retain) id Close;

@end
