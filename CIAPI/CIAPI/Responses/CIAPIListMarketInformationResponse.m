//
//  CIAPIListMarketInformationResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationResponse.h"

#import "CIAPIMarketInformation.h"


@implementation CIAPIListMarketInformationResponse 

@synthesize MarketInformation;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"MarketInformation"]) return [CIAPIMarketInformation class];
  return nil;
}

@end

