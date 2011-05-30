//
//  CIAPIMarketInformation.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIMarketInformation : CIAPIObjectResponse {
  NSInteger MarketId;
  NSString* Name;
  NSString* MarginFactor;
  NSString* MinDistance;
  NSString* WebMinSize;
  NSString* MaxSize;
  BOOL Market24H;
  NSString* PriceDecimalPlaces;
  NSString* DefaultQuoteLength;
  BOOL TradeOnWeb;
  BOOL LimitUp;
  BOOL LimitDown;
  BOOL LongPositionOnly;
  BOOL CloseOnly;
  NSArray* MarketEod;
}

// market id. 
@property (readonly) NSInteger MarketId;
// The market name 
@property (readonly) NSString* Name;
// Margin factor, expressed as points or a percentage. 
@property (readonly) NSString* MarginFactor;
// The minimum distance from the current price you can place an order. 
@property (readonly) NSString* MinDistance;
// The minimum quantity that can be traded over the web. 
@property (readonly) NSString* WebMinSize;
// The max size of an order. 
@property (readonly) NSString* MaxSize;
// Is the market a 24 hour market. 
@property (readonly) BOOL Market24H;
// the number of decimal places in the market's price. 
@property (readonly) NSString* PriceDecimalPlaces;
// default quote length. 
@property (readonly) NSString* DefaultQuoteLength;
// Can you trade this market on the web. 
@property (readonly) BOOL TradeOnWeb;
// New sell orders will be rejected. Orders resulting in a short open position will be red carded. 
@property (readonly) BOOL LimitUp;
// New buy orders will be rejected. Orders resulting in a long open position will be red carded. 
@property (readonly) BOOL LimitDown;
// Cannot open a short position. Equivalent to limit up. 
@property (readonly) BOOL LongPositionOnly;
// Can only close open positions. Equivalent to both Limit up and Limit down. 
@property (readonly) BOOL CloseOnly;
// list of market end of day dtos. 
@property (readonly) NSArray* MarketEod;

@end
