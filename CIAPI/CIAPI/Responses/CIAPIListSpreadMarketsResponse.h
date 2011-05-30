//
//  CIAPIListSpreadMarketsResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListSpreadMarketsResponse : CIAPIObjectListResponse {
  NSArray* Markets;
}

// A list of Spread Betting markets 
@property (readonly) NSArray* Markets;

@end
