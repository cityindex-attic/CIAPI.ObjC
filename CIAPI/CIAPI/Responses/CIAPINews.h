//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPINews : CIAPIObjectResponse {
  NSInteger StoryId;
  NSString* Headline;
  NSString* PublishDate;
}

// The unique identifier for a news story 
@property (readonly) NSInteger StoryId;
// The News story headline 
@property (readonly) NSString* Headline;
// The date on which the news story was published. Always in UTC 
@property (readonly) NSString* PublishDate;

@end
