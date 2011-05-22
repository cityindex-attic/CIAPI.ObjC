//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIStopLimitOrder : NSObject {
  id ExpiryDateTimeUTC;
  id Applicability;
}

// The associated expiry DateTime for a pair of GoodTillDate IfDone orders 
@property (readonly) id ExpiryDateTimeUTC;
// Identifier which relates to the expiry of the order/trade, i.e. GoodTillDate (GTD), GoodTillCancelled (GTC) or GoodForDay (GFD) 
@property (readonly) id Applicability;

@end
