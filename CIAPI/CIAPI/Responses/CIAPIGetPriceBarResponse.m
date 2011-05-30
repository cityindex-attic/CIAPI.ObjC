//
//  CIAPIGetPriceBarResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetPriceBarResponse.h"

#import "CIAPIPriceBar.h"


@implementation CIAPIGetPriceBarResponse 

@synthesize PriceBars;
@synthesize PartialPriceBar;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"PriceBars"]) return [CIAPIPriceBar class];
  return nil;
}

@end

