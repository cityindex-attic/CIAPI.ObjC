//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIMarketInformation : NSObject {
  id MarketId;
  id Name;
  id MarginFactor;
  id MinDistance;
  id WebMinSize;
  id MaxSize;
  id Market24H;
  id PriceDecimalPlaces;
  id DefaultQuoteLength;
  id TradeOnWeb;
  id LimitUp;
  id LimitDown;
  id LongPositionOnly;
  id CloseOnly;
  id MarketEod;
}

// market id. 
@property (readonly) id MarketId;
// The market name 
@property (readonly) id Name;
// Margin factor, expressed as points or a percentage. 
@property (readonly) id MarginFactor;
// The minimum distance from the current price you can place an order. 
@property (readonly) id MinDistance;
// The minimum quantity that can be traded over the web. 
@property (readonly) id WebMinSize;
// The max size of an order. 
@property (readonly) id MaxSize;
// Is the market a 24 hour market. 
@property (readonly) id Market24H;
// the number of decimal places in the market's price. 
@property (readonly) id PriceDecimalPlaces;
// default quote length. 
@property (readonly) id DefaultQuoteLength;
// Can you trade this market on the web. 
@property (readonly) id TradeOnWeb;
// New sell orders will be rejected. Orders resulting in a short open position will be red carded. 
@property (readonly) id LimitUp;
// New buy orders will be rejected. Orders resulting in a long open position will be red carded. 
@property (readonly) id LimitDown;
// Cannot open a short position. Equivalent to limit up. 
@property (readonly) id LongPositionOnly;
// Can only close open positions. Equivalent to both Limit up and Limit down. 
@property (readonly) id CloseOnly;
// list of market end of day dtos. 
@property (readonly) id MarketEod;

@end
