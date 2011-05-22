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
  id MarketIds;
}

  // The list of market ids 
  @property (retain) id MarketIds;

@end
