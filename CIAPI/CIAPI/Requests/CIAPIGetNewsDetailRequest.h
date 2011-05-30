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
 NSString* storyId;
}

// The news story Id 
@property (retain) NSString* storyId;

@end
