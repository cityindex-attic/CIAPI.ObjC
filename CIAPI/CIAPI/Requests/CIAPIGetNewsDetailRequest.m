//
//  CIAPIGetNewsDetailRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetNewsDetailRequest.h"

#import "CIAPIGetNewsDetailResponse.h"

@implementation CIAPIGetNewsDetailRequest

@synthesize storyId;



- (CIAPIGetNewsDetailRequest*)initWithStoryId:(NSString*)_storyId{
  self = [super init];

  if (self)
  {
    self.storyId = _storyId;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"news/{storyId}";
}

- (Class)responseClass
{
    return [CIAPIGetNewsDetailResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}

- (NSTimeInterval)cacheDuration
{
  return 10.0;
}

@end

