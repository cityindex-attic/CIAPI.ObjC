//
//  CIAPIListMarketInformationRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Queries for market information.</p>
 
@interface CIAPIListMarketInformationRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSArray* MarketIds;
}

// Properties for each field
// The list of market ids 
@property (retain) NSArray* MarketIds;

// Constructor for the object
- (CIAPIListMarketInformationRequest*)initWithMarketIds:(NSArray*)_MarketIds;


@end

