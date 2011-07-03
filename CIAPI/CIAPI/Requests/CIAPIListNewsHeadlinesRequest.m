//
//  CIAPIListNewsHeadlinesRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListNewsHeadlinesRequest.h"

#import "CIAPIListNewsHeadlinesResponse.h"

@implementation CIAPIListNewsHeadlinesRequest

@synthesize category;
@synthesize maxResults;



- (CIAPIListNewsHeadlinesRequest*)initWithCategory:(NSString*)_category{
  self = [super init];

  if (self)
  {
    self.category = _category;
    self.maxResults = 25;
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
    return @"news?Category={category}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListNewsHeadlinesResponse class];
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

