//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListNewsHeadlinesResponse : CIAPIObjectListResponse {
  id Headlines;
}

// A list of News headlines 
@property (readonly) id Headlines;

@end
