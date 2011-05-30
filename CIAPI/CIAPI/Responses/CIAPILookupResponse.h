//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPILookupResponse : CIAPIObjectResponse {
  NSInteger CultureId;
  NSString* LookupEntityName;
  NSArray* ApiLookupDTOList;
}

// The culture id requested 
@property (readonly) NSInteger CultureId;
// The lookup name requested 
@property (readonly) NSString* LookupEntityName;
// List of lookup entities from the database 
@property (readonly) NSArray* ApiLookupDTOList;

@end
