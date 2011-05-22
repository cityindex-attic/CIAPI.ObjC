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
  id category;
  id maxResults;
}

  // Filter headlines by category 
  @property (retain) id category;
  // Restrict the number of headlines returned 
  @property (retain) id maxResults;

@end
