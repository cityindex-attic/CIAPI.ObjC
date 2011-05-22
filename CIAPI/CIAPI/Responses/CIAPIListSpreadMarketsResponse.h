//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListSpreadMarketsResponse : CIAPIObjectListResponse {
  id Markets;
}

// A list of Spread Betting markets 
@property (readonly) id Markets;

@end
