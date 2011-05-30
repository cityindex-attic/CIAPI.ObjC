//
//  CIAPIListNewsHeadlinesResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListNewsHeadlinesResponse.h"

#import "CIAPINews.h"


@implementation CIAPIListNewsHeadlinesResponse 

@synthesize Headlines;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"Headlines"]) return [CIAPINews class];
  return nil;
}

@end

