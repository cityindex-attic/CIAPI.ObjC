//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIStopLimitOrderHistory : NSObject {
  id OrderId;
  id MarketId;
  id MarketName;
  id Direction;
  id OriginalQuantity;
  id Price;
  id TriggerPrice;
  id TradingAccountId;
  id TypeId;
  id OrderApplicabilityId;
  id Currency;
  id StatusId;
  id LastChangedDateTimeUtc;
}

// The order's unique identifier. 
@property (readonly) id OrderId;
// The markets unique identifier. 
@property (readonly) id MarketId;
// The market's name. 
@property (readonly) id MarketName;
// The direction, buy or sell. 
@property (readonly) id Direction;
// The quantity of the order when it became a trade / was cancelled etc. 
@property (readonly) id OriginalQuantity;
// The price / rate that the order was filled at. 
@property (readonly) id Price;
// The price / rate that the the order was set to trigger at. 
@property (readonly) id TriggerPrice;
// The trading account that the order is on. 
@property (readonly) id TradingAccountId;
// The type of the order stop, limit or trade. 
@property (readonly) id TypeId;
// When the order applies until. i.e. good till cancelled (GTC) good for day (GFD) or good till time (GTT). 
@property (readonly) id OrderApplicabilityId;
// The trade currency. 
@property (readonly) id Currency;
// the order status. 
@property (readonly) id StatusId;
// The last time that the order changed. Note - Does not include things such as the current market price. 
@property (readonly) id LastChangedDateTimeUtc;

@end
