//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIPriceTick : NSObject {
  id TickDate;
  id Price;
}

// The datetime at which a price tick occurred. Accurate to the millisecond 
@property (readonly) id TickDate;
// The mid price 
@property (readonly) id Price;

@end
