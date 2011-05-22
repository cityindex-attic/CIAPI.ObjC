//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPINews : NSObject {
  id StoryId;
  id Headline;
  id PublishDate;
}

// The unique identifier for a news story 
@property (readonly) id StoryId;
// The News story headline 
@property (readonly) id Headline;
// The date on which the news story was published. Always in UTC 
@property (readonly) id PublishDate;

@end
