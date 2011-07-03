//
//  CIAPIListNewsHeadlinesRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Get a list of current news headlines
 
@interface CIAPIListNewsHeadlinesRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* category;
  NSInteger maxResults;
}

// Properties for each field
// Filter headlines by category 
@property (retain) NSString* category;
// Restrict the number of headlines returned 
@property  NSInteger maxResults;

// Constructor for the object
- (CIAPIListNewsHeadlinesRequest*)initWithCategory:(NSString*)_category;


@end

