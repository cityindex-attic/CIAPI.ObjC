//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPILookupResponse : CIAPIObjectResponse {
  id CultureId;
  id LookupEntityName;
  id ApiLookupDTOList;
}

// The culture id requested 
@property (readonly) id CultureId;
// The lookup name requested 
@property (readonly) id LookupEntityName;
// List of lookup entities from the database 
@property (readonly) id ApiLookupDTOList;

@end
