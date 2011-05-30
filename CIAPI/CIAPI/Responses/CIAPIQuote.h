//
//  CIAPIQuote.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIQuote : CIAPIObjectResponse {
  NSInteger QuoteId;
  NSInteger OrderId;
  NSInteger MarketId;
  double BidPrice;
  double BidAdjust;
  double OfferPrice;
  double OfferAdjust;
  double Quantity;
  NSInteger CurrencyId;
  NSInteger StatusId;
  NSInteger TypeId;
  NSString* RequestDateTime;
}

// The uniqueId of the Quote 
@property (readonly) NSInteger QuoteId;
// The Order the Quote is related to 
@property (readonly) NSInteger OrderId;
// The Market the Quote is related to 
@property (readonly) NSInteger MarketId;
// The Price of the original Order request for a Buy 
@property (readonly) double BidPrice;
// The amount the bid price will be adjusted to become an order when the customer is buying (BidPrice + BidAdjust = BuyPrice) 
@property (readonly) double BidAdjust;
// The Price of the original Order request for a Sell 
@property (readonly) double OfferPrice;
// The amount the offer price will be adjusted to become an order when the customer is selling (OfferPrice + OfferAdjust = OfferPrice) 
@property (readonly) double OfferAdjust;
// The Quantity is the number of units for the trade i.e CFD Quantity = Number of CFD's to Buy or Sell , FX Quantity = amount in base currency. 
@property (readonly) double Quantity;
// The system internal Id for the ISO Currency the equivalent ISO Code can be found using the API Call TODO Fill when the API call is available 
@property (readonly) NSInteger CurrencyId;
// The Status id of the Quote. The list of different Status values can be found using the API call TODO Fill when call avaliable 
@property (readonly) NSInteger StatusId;
// The quote type id. 
@property (readonly) NSInteger TypeId;
// The timestamp the quote was requested. Always expressed in UTC 
@property (readonly) NSString* RequestDateTime;

@end
