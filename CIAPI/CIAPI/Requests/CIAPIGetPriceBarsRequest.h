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
  id marketId;
  id interval;
  id span;
  id priceBars;
}

  // The marketId 
  @property (retain) id marketId;
  // The pricebar interval 
  @property (retain) id interval;
  // The number of each interval per pricebar. 
  @property (retain) id span;
  // The total number of pricebars to return 
  @property (retain) id priceBars;

@end
