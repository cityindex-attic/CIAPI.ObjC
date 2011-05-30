//
//  CIAPIListOpenPositionsResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListOpenPositionsResponse.h"

#import "CIAPIOpenPosition.h"


@implementation CIAPIListOpenPositionsResponse 

@synthesize OpenPositions;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"OpenPositions"]) return [CIAPIOpenPosition class];
  return nil;
}

@end

