//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListNewsHeadlinesResponse : CIAPIObjectListResponse {
  NSArray* Headlines;
}

// A list of News headlines 
@property (readonly) NSArray* Headlines;

@end
