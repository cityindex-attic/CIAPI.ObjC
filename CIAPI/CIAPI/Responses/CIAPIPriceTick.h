//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIPriceTick : CIAPIObjectResponse {
  NSString* TickDate;
  double Price;
}

// The datetime at which a price tick occurred. Accurate to the millisecond 
@property (readonly) NSString* TickDate;
// The mid price 
@property (readonly) double Price;

@end
