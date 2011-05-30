//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIMarket : CIAPIObjectResponse {
  NSInteger MarketId;
  NSString* Name;
}

// A market's unique identifier 
@property (readonly) NSInteger MarketId;
// The market name 
@property (readonly) NSString* Name;

@end
