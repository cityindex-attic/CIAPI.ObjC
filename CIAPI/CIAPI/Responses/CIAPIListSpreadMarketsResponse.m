//
//  CIAPIListSpreadMarketsResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListSpreadMarketsResponse.h"

#import "CIAPIMarket.h"


@implementation CIAPIListSpreadMarketsResponse 

@synthesize Markets;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"Markets"]) return [CIAPIMarket class];
  return nil;
}

@end

