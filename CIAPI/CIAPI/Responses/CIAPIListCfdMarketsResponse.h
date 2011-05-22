//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListCfdMarketsResponse : CIAPIObjectListResponse {
  id Markets;
}

// A list of CFD markets 
@property (readonly) id Markets;

@end
