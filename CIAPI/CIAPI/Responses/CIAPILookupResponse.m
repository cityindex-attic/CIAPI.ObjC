//
//  CIAPILookupResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPILookupResponse.h"

#import "CIAPILookup.h"


@implementation CIAPILookupResponse 

@synthesize CultureId;
@synthesize LookupEntityName;
@synthesize ApiLookupDTOList;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"ApiLookupDTOList"]) return [CIAPILookup class];
  return nil;
}

@end

