//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIBasicStopLimitOrder : NSObject {
  id OrderId;
  id TriggerPrice;
  id Quantity;
}

// The order's unique identifier. 
@property (readonly) id OrderId;
// The order's trigger price. 
@property (readonly) id TriggerPrice;
// The quantity of the product. 
@property (readonly) id Quantity;

@end
