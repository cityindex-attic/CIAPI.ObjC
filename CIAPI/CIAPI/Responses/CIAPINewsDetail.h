//
//  CIAPINewsDetail.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPINewsDetail : CIAPIObjectResponse {
  NSString* Story;
}

// The detail of the story. This can contain HTML characters. 
@property (readonly) NSString* Story;

@end
