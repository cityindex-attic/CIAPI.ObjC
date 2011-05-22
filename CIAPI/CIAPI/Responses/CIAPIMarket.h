//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIMarket : NSObject {
  id MarketId;
  id Name;
}

// A market's unique identifier 
@property (readonly) id MarketId;
// The market name 
@property (readonly) id Name;

@end
