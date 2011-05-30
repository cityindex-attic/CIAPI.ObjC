//
//  CIAPIListMarketInformationSearchResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationSearchResponse.h"

#import "CIAPIMarketInformation.h"


@implementation CIAPIListMarketInformationSearchResponse 

@synthesize MarketInformation;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"MarketInformation"]) return [CIAPIMarketInformation class];
  return nil;
}

@end

