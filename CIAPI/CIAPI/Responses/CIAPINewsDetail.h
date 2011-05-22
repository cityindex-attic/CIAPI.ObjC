//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPINewsDetail : NSObject {
  id Story;
}

// The detail of the story. This can contain HTML characters. 
@property (readonly) id Story;

@end
