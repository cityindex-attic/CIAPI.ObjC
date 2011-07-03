//
//  CIAPIGetPriceBarsRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Get historic price bars in OHLC (open, high, low, close) format, suitable for
//  plotting candlestick chartsReturns price bars in ascending order up to the c
// urrent time.When there are no prices per a particular time period, no price b
// ar is returned. Thus, it can appear that the array of price bars has "gaps", 
// i.e. the gap between the datetime of each price bar might not be equal to int
// erval x spanSample Urls: /market/1234/history?interval=MINUTE&span=15&priceba
// rs=180/market/735/history?interval=HOUR&span=1&pricebars=240/market/1577/hist
// ory?interval=DAY&span=1&pricebars=10
 
@interface CIAPIGetPriceBarsRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* marketId;
  NSString* interval;
  NSInteger span;
  NSString* priceBars;
}

// Properties for each field
// The marketId 
@property (retain) NSString* marketId;
// The pricebar interval 
@property (retain) NSString* interval;
// The number of each interval per pricebar. 
@property  NSInteger span;
// The total number of pricebars to return 
@property (retain) NSString* priceBars;

// Constructor for the object
- (CIAPIGetPriceBarsRequest*)initWithMarketId:(NSString*)_marketId interval:(NSString*)_interval span:(NSInteger)_span priceBars:(NSString*)_priceBars;


@end

