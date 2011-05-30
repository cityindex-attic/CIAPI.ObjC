//
//  CIAPIMarketEod.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIMarketEod : CIAPIObjectResponse {
  NSString* MarketEodUnit;
  NSString* MarketEodAmount;
}

// Unit 
@property (readonly) NSString* MarketEodUnit;
// End of day amount. 
@property (readonly) NSString* MarketEodAmount;

@end
