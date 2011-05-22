//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetPriceTickResponse : CIAPIObjectResponse {
  id PriceTicks;
}

// An array of price ticks, sorted in ascending order by PriceTick.TickDate 
@property (readonly) id PriceTicks;

@end
