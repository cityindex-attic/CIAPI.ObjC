//
//  CIAPIActiveStopLimitOrder.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIBasicStopLimitOrder.h"
#import "CIAPIBasicStopLimitOrder.h"
#import "CIAPIBasicStopLimitOrder.h"


@interface CIAPIActiveStopLimitOrder : CIAPIObjectResponse {
  NSInteger OrderId;
  NSString* ParentOrderId;
  NSInteger MarketId;
  NSString* MarketName;
  NSString* Direction;
  double Quantity;
  double TriggerPrice;
  double TradingAccountId;
  NSInteger Type;
  NSInteger Applicability;
  NSString* ExpiryDateTimeUTC;
  NSString* Currency;
  NSInteger Status;
  CIAPIBasicStopLimitOrder* StopOrder;
  CIAPIBasicStopLimitOrder* LimitOrder;
  CIAPIBasicStopLimitOrder* OcoOrder;
  NSString* LastChangedDateTimeUTC;
}

// The order's unique identifier. 
@property (readonly) NSInteger OrderId;
// The order's parent OrderId. 
@property (readonly) NSString* ParentOrderId;
// The markets unique identifier. 
@property (readonly) NSInteger MarketId;
// The market's name. 
@property (readonly) NSString* MarketName;
// The direction, buy or sell. 
@property (readonly) NSString* Direction;
// The quantity of the product. 
@property (readonly) double Quantity;
// The marked to market price at which the order will trigger at. 
@property (readonly) double TriggerPrice;
// The trading account that the order is on. 
@property (readonly) double TradingAccountId;
// The type of order, i.e. stop or limit. 
@property (readonly) NSInteger Type;
// When the order applies until. i.e. good till cancelled (GTC) good for day (GFD) or good till time (GTT). 
@property (readonly) NSInteger Applicability;
// The associated expiry DateTime. 
@property (readonly) NSString* ExpiryDateTimeUTC;
// The trade currency. 
@property (readonly) NSString* Currency;
// The order status. 
@property (readonly) NSInteger Status;
// The if done stop order. 
@property (readonly) CIAPIBasicStopLimitOrder* StopOrder;
// The if done limit order 
@property (readonly) CIAPIBasicStopLimitOrder* LimitOrder;
// The order on the other side of a one Cancels the other relationship. 
@property (readonly) CIAPIBasicStopLimitOrder* OcoOrder;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) NSString* LastChangedDateTimeUTC;

@end
