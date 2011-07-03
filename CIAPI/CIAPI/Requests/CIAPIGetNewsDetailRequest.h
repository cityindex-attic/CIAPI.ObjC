//
//  CIAPIGetNewsDetailRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Get the detail of a specific news story
 
@interface CIAPIGetNewsDetailRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* storyId;
}

// Properties for each field
// The news story Id 
@property (retain) NSString* storyId;

// Constructor for the object
- (CIAPIGetNewsDetailRequest*)initWithStoryId:(NSString*)_storyId;


@end

