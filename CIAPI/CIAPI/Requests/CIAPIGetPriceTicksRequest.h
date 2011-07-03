//
//  CIAPIGetPriceTicksRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Get historic price ticks. Returns price ticks in ascending order up to the cu
// rrent time. The length of time between each tick will be different.
 
@interface CIAPIGetPriceTicksRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* marketId;
  NSString* priceTicks;
}

// Properties for each field
// The marketId 
@property (retain) NSString* marketId;
// The total number of price ticks to return 
@property (retain) NSString* priceTicks;

// Constructor for the object
- (CIAPIGetPriceTicksRequest*)initWithMarketId:(NSString*)_marketId priceTicks:(NSString*)_priceTicks;


@end

