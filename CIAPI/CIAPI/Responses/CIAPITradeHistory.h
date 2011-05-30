//
//  CIAPITradeHistory.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPITradeHistory : CIAPIObjectResponse {
  NSInteger OrderId;
  NSInteger MarketId;
  NSString* MarketName;
  NSString* Direction;
  double OriginalQuantity;
  double Price;
  NSInteger TradingAccountId;
  NSString* Currency;
  NSString* LastChangedDateTimeUtc;
  NSString* ExecutedDateTimeUtc;
}

// The order id. 
@property (readonly) NSInteger OrderId;
// The market id. 
@property (readonly) NSInteger MarketId;
// The name of the market. 
@property (readonly) NSString* MarketName;
// The direction of the trade. 
@property (readonly) NSString* Direction;
// The original quantity of the trade, before part closures. 
@property (readonly) double OriginalQuantity;
// The open price of the trade. 
@property (readonly) double Price;
// The trading account that the order is on. 
@property (readonly) NSInteger TradingAccountId;
// The trade currency. 
@property (readonly) NSString* Currency;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) NSString* LastChangedDateTimeUtc;
// The time the order was executed. 
@property (readonly) NSString* ExecutedDateTimeUtc;

@end
