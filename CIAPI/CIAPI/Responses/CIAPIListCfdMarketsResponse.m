//
//  CIAPIListCfdMarketsResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListCfdMarketsResponse.h"

#import "CIAPIMarket.h"


@implementation CIAPIListCfdMarketsResponse 

@synthesize Markets;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"Markets"]) return [CIAPIMarket class];
  return nil;
}

@end

