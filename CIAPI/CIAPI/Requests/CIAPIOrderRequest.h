//
//  CIAPIOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

#import "CIAPINewStopLimitOrderRequest.h"

// <p>Place an order on a particular market. Post a <a onclick="dojo.hash('#type
// .NewStopLimitOrderRequestDTO'); return false;" class="json-link" href="#">New
// StopLimitOrderRequestDTO</a> to the uri specified below.</p> <p>Do not set an
// y order id fields when requesting a new order, the platform will generate the
// m.</p>
 
@interface CIAPIOrderRequest : CIAPIObjectRequest {
 NSInteger OrderId;
 NSInteger MarketId;
 NSString* Currency;
 BOOL AutoRollover;
 NSString* Direction;
 double Quantity;
 double BidPrice;
 double OfferPrice;
 NSString* AuditId;
 NSInteger TradingAccountId;
 NSArray* IfDone;
 CIAPINewStopLimitOrderRequest* OcoOrder;
 NSString* Applicability;
 NSString* ExpiryDateTimeUTC;
 BOOL Guaranteed;
 double TriggerPrice;
}

// Order identifier of the order to update 
@property  NSInteger OrderId;
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
// Corresponding OcoOrder (One Cancels the Other) 
@property (retain) CIAPINewStopLimitOrderRequest* OcoOrder;
// Identifier which relates to the expiry of the            order/trade, i.e. GoodTillDate (GTD),             GoodTillCancelled (GTC) or GoodForDay (GFD) 
@property (retain) NSString* Applicability;
// The associated expiry DateTime for a             pair of GoodTillDate IfDone orders 
@property (retain) NSString* ExpiryDateTimeUTC;
// Flag to determine whether an order is guaranteed to trigger and fill at            the associated trigger price 
@property  BOOL Guaranteed;
// Price at which the order is intended to be triggered 
@property  double TriggerPrice;

@end
