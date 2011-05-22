//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIOrder : NSObject {
  id OrderId;
  id MarketId;
  id ClientAccountId;
  id TradingAccountId;
  id CurrencyId;
  id CurrencyISO;
  id Direction;
  id AutoRollover;
  id ExecutionPrice;
  id LastChangedTime;
  id OpenPrice;
  id OriginalLastChangedDateTime;
  id OriginalQuantity;
  id PositionMethodId;
  id Quantity;
  id Type;
  id Status;
  id ReasonId;
}

// Order id 
@property (readonly) id OrderId;
// Market id. 
@property (readonly) id MarketId;
// Client account id. 
@property (readonly) id ClientAccountId;
// Trading account id. 
@property (readonly) id TradingAccountId;
// Trade currency id. 
@property (readonly) id CurrencyId;
// Trade currency ISO code. 
@property (readonly) id CurrencyISO;
// direction of the order. 
@property (readonly) id Direction;
// Does the order automatically roll over. 
@property (readonly) id AutoRollover;
// the price the order was executed at. 
@property (readonly) id ExecutionPrice;
// The date time that the order was last changed. Always expressed in UTC. 
@property (readonly) id LastChangedTime;
// the open price of the order. 
@property (readonly) id OpenPrice;
// The date of the Order. Always expressed in UTC 
@property (readonly) id OriginalLastChangedDateTime;
// The orders original quantity, before any part / full closures. 
@property (readonly) id OriginalQuantity;
// The position method of the order. 
@property (readonly) id PositionMethodId;
// The current quantity of the order. 
@property (readonly) id Quantity;
// the type of the order (1 = Trade / 2 = Stop / 3 = Limit) 
@property (readonly) id Type;
// The order status id. 
@property (readonly) id Status;
// the order status reason is. 
@property (readonly) id ReasonId;

@end
