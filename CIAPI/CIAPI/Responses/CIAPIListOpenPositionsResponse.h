//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListOpenPositionsResponse : CIAPIObjectListResponse {
  NSArray* OpenPositions;
}

// A list of trades / open positions. 
@property (readonly) NSArray* OpenPositions;

@end
