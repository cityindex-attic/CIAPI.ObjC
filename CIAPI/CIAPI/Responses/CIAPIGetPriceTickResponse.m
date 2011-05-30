//
//  CIAPIGetPriceTickResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceTickResponse.h"

#import "CIAPIPriceTick.h"


@implementation CIAPIGetPriceTickResponse 

@synthesize PriceTicks;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"PriceTicks"]) return [CIAPIPriceTick class];
  return nil;
}

@end

