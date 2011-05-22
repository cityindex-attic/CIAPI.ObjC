//
//  CIAPIOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

// <p>Place an order on a particular market. Post a <a onclick="dojo.hash('#type
// .NewStopLimitOrderRequestDTO'); return false;" class="json-link" href="#">New
// StopLimitOrderRequestDTO</a> to the uri specified below.</p> <p>Do not set an
// y order id fields when requesting a new order, the platform will generate the
// m.</p>
 
@interface CIAPIOrderRequest : CIAPIObjectRequest {
  id OrderId;
  id MarketId;
  id Currency;
  id AutoRollover;
  id Direction;
  id Quantity;
  id BidPrice;
  id OfferPrice;
  id AuditId;
  id TradingAccountId;
  id IfDone;
  id OcoOrder;
  id Applicability;
  id ExpiryDateTimeUTC;
  id Guaranteed;
  id TriggerPrice;
}

  // Order identifier of the order to update 
  @property (retain) id OrderId;
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
  // Corresponding OcoOrder (One Cancels the Other) 
  @property (retain) id OcoOrder;
  // Identifier which relates to the expiry of the
            order/trade, i.e. GoodTillDate (GTD), 
            GoodTillCancelled (GTC) or GoodForDay (GFD) 
  @property (retain) id Applicability;
  // The associated expiry DateTime for a 
            pair of GoodTillDate IfDone orders 
  @property (retain) id ExpiryDateTimeUTC;
  // Flag to determine whether an order is guaranteed to trigger and fill at
            the associated trigger price 
  @property (retain) id Guaranteed;
  // Price at which the order is intended to be triggered 
  @property (retain) id TriggerPrice;

@end
