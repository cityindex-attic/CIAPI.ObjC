//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListMarketInformationResponse : CIAPIObjectListResponse {
  NSArray* MarketInformation;
}

// The requested list of market information. 
@property (readonly) NSArray* MarketInformation;

@end
