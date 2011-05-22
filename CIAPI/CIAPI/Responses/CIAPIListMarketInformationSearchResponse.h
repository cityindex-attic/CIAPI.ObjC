//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListMarketInformationSearchResponse : CIAPIObjectListResponse {
  id MarketInformation;
}

// The requested list of market information. 
@property (readonly) id MarketInformation;

@end
