//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIQuote : NSObject {
  id QuoteId;
  id OrderId;
  id MarketId;
  id BidPrice;
  id BidAdjust;
  id OfferPrice;
  id OfferAdjust;
  id Quantity;
  id CurrencyId;
  id StatusId;
  id TypeId;
  id RequestDateTime;
}

// The uniqueId of the Quote 
@property (readonly) id QuoteId;
// The Order the Quote is related to 
@property (readonly) id OrderId;
// The Market the Quote is related to 
@property (readonly) id MarketId;
// The Price of the original Order request for a Buy 
@property (readonly) id BidPrice;
// The amount the bid price will be adjusted to become an order when the customer is buying (BidPrice + BidAdjust = BuyPrice) 
@property (readonly) id BidAdjust;
// The Price of the original Order request for a Sell 
@property (readonly) id OfferPrice;
// The amount the offer price will be adjusted to become an order when the customer is selling (OfferPrice + OfferAdjust = OfferPrice) 
@property (readonly) id OfferAdjust;
// The Quantity is the number of units for the trade i.e CFD Quantity = Number of CFD's to Buy or Sell , FX Quantity = amount in base currency. 
@property (readonly) id Quantity;
// The system internal Id for the ISO Currency the equivalent ISO Code can be found using the API Call TODO Fill when the API call is available 
@property (readonly) id CurrencyId;
// The Status id of the Quote. The list of different Status values can be found using the API call TODO Fill when call avaliable 
@property (readonly) id StatusId;
// The quote type id. 
@property (readonly) id TypeId;
// The timestamp the quote was requested. Always expressed in UTC 
@property (readonly) id RequestDateTime;

@end
