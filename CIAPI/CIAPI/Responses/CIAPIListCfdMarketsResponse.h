//
//  CIAPIListCfdMarketsResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListCfdMarketsResponse : CIAPIObjectListResponse {
  NSArray* Markets;
}

// A list of CFD markets 
@property (readonly) NSArray* Markets;

@end
