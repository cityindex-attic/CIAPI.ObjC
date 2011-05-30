//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIStopLimitOrderHistory : CIAPIObjectResponse {
  NSInteger OrderId;
  NSInteger MarketId;
  NSString* MarketName;
  NSString* Direction;
  double OriginalQuantity;
  NSString* Price;
  double TriggerPrice;
  NSInteger TradingAccountId;
  NSInteger TypeId;
  NSInteger OrderApplicabilityId;
  NSString* Currency;
  NSInteger StatusId;
  NSString* LastChangedDateTimeUtc;
}

// The order's unique identifier. 
@property (readonly) NSInteger OrderId;
// The markets unique identifier. 
@property (readonly) NSInteger MarketId;
// The market's name. 
@property (readonly) NSString* MarketName;
// The direction, buy or sell. 
@property (readonly) NSString* Direction;
// The quantity of the order when it became a trade / was cancelled etc. 
@property (readonly) double OriginalQuantity;
// The price / rate that the order was filled at. 
@property (readonly) NSString* Price;
// The price / rate that the the order was set to trigger at. 
@property (readonly) double TriggerPrice;
// The trading account that the order is on. 
@property (readonly) NSInteger TradingAccountId;
// The type of the order stop, limit or trade. 
@property (readonly) NSInteger TypeId;
// When the order applies until. i.e. good till cancelled (GTC) good for day (GFD) or good till time (GTT). 
@property (readonly) NSInteger OrderApplicabilityId;
// The trade currency. 
@property (readonly) NSString* Currency;
// the order status. 
@property (readonly) NSInteger StatusId;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) NSString* LastChangedDateTimeUtc;

@end
