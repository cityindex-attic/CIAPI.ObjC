//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIMarketEod : NSObject {
  id MarketEodUnit;
  id MarketEodAmount;
}

// Unit 
@property (readonly) id MarketEodUnit;
// End of day amount. 
@property (readonly) id MarketEodAmount;

@end
