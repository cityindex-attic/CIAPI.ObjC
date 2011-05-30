//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIBasicStopLimitOrder : CIAPIObjectResponse {
  NSInteger OrderId;
  double TriggerPrice;
  double Quantity;
}

// The order's unique identifier. 
@property (readonly) NSInteger OrderId;
// The order's trigger price. 
@property (readonly) double TriggerPrice;
// The quantity of the product. 
@property (readonly) double Quantity;

@end
