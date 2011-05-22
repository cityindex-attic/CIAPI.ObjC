//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListOpenPositionsResponse : CIAPIObjectListResponse {
  id OpenPositions;
}

// A list of trades / open positions. 
@property (readonly) id OpenPositions;

@end
