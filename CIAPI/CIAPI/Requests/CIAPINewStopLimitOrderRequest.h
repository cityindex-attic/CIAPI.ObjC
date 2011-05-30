//
//  CIAPINewStopLimitOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPINewStopLimitOrderRequest.h"


@interface CIAPINewStopLimitOrderRequest : CIAPIObjectResponse {
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
@property (readonly) NSInteger OrderId;
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
// Corresponding OcoOrder (One Cancels the Other) 
@property (readonly) CIAPINewStopLimitOrderRequest* OcoOrder;
// Identifier which relates to the expiry of the order/trade, i.e. GoodTillDate (GTD), GoodTillCancelled (GTC) or GoodForDay (GFD) 
@property (readonly) NSString* Applicability;
// The associated expiry DateTime for a pair of GoodTillDate IfDone orders 
@property (readonly) NSString* ExpiryDateTimeUTC;
// Flag to determine whether an order is guaranteed to trigger and fill at the associated trigger price 
@property (readonly) BOOL Guaranteed;
// Price at which the order is intended to be triggered 
@property (readonly) double TriggerPrice;

@end
