//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPITradeHistory : NSObject {
  id OrderId;
  id MarketId;
  id MarketName;
  id Direction;
  id OriginalQuantity;
  id Price;
  id TradingAccountId;
  id Currency;
  id LastChangedDateTimeUtc;
  id ExecutedDateTimeUtc;
}

// The order id. 
@property (readonly) id OrderId;
// The market id. 
@property (readonly) id MarketId;
// The name of the market. 
@property (readonly) id MarketName;
// The direction of the trade. 
@property (readonly) id Direction;
// The original quantity of the trade, before part closures. 
@property (readonly) id OriginalQuantity;
// The open price of the trade. 
@property (readonly) id Price;
// The trading account that the order is on. 
@property (readonly) id TradingAccountId;
// The trade currency. 
@property (readonly) id Currency;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) id LastChangedDateTimeUtc;
// The time the order was executed. 
@property (readonly) id ExecutedDateTimeUtc;

@end
