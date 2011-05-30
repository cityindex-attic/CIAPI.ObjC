//
//  CIAPIOrder.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIOrder : CIAPIObjectResponse {
  NSInteger OrderId;
  NSInteger MarketId;
  NSInteger ClientAccountId;
  NSInteger TradingAccountId;
  NSInteger CurrencyId;
  NSString* CurrencyISO;
  NSInteger Direction;
  BOOL AutoRollover;
  double ExecutionPrice;
  NSString* LastChangedTime;
  double OpenPrice;
  NSString* OriginalLastChangedDateTime;
  double OriginalQuantity;
  NSInteger PositionMethodId;
  double Quantity;
  NSString* Type;
  NSString* Status;
  NSInteger ReasonId;
}

// Order id 
@property (readonly) NSInteger OrderId;
// Market id. 
@property (readonly) NSInteger MarketId;
// Client account id. 
@property (readonly) NSInteger ClientAccountId;
// Trading account id. 
@property (readonly) NSInteger TradingAccountId;
// Trade currency id. 
@property (readonly) NSInteger CurrencyId;
// Trade currency ISO code. 
@property (readonly) NSString* CurrencyISO;
// direction of the order. 
@property (readonly) NSInteger Direction;
// Does the order automatically roll over. 
@property (readonly) BOOL AutoRollover;
// the price the order was executed at. 
@property (readonly) double ExecutionPrice;
// The date time that the order was last changed. Always expressed in UTC. 
@property (readonly) NSString* LastChangedTime;
// the open price of the order. 
@property (readonly) double OpenPrice;
// The date of the Order. Always expressed in UTC 
@property (readonly) NSString* OriginalLastChangedDateTime;
// The orders original quantity, before any part / full closures. 
@property (readonly) double OriginalQuantity;
// The position method of the order. 
@property (readonly) NSInteger PositionMethodId;
// The current quantity of the order. 
@property (readonly) double Quantity;
// the type of the order (1 = Trade / 2 = Stop / 3 = Limit) 
@property (readonly) NSString* Type;
// The order status id. 
@property (readonly) NSString* Status;
// the order status reason is. 
@property (readonly) NSInteger ReasonId;

@end
