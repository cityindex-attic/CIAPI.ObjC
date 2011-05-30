//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIGetPriceTickResponse : CIAPIObjectResponse {
  NSArray* PriceTicks;
}

// An array of price ticks, sorted in ascending order by PriceTick.TickDate 
@property (readonly) NSArray* PriceTicks;

@end
