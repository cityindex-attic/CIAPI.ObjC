//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIStopLimitOrder.h"
#import "CIAPIStopLimitOrder.h"


@interface CIAPIIfDone : CIAPIObjectResponse {
  CIAPIStopLimitOrder* Stop;
  CIAPIStopLimitOrder* Limit;
}

// The price at which the stop order will be filled 
@property (readonly) CIAPIStopLimitOrder* Stop;
// The price at which the limit order will be filled 
@property (readonly) CIAPIStopLimitOrder* Limit;

@end
