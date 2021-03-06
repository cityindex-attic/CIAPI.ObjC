//
//  CIAPIMarketInformation.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIMarketInformation.h"

#import "CIAPIMarketEod.h"


@implementation CIAPIMarketInformation 

@synthesize MarketId;
@synthesize Name;
@synthesize MarginFactor;
@synthesize MinDistance;
@synthesize WebMinSize;
@synthesize MaxSize;
@synthesize Market24H;
@synthesize PriceDecimalPlaces;
@synthesize DefaultQuoteLength;
@synthesize TradeOnWeb;
@synthesize LimitUp;
@synthesize LimitDown;
@synthesize LongPositionOnly;
@synthesize CloseOnly;
@synthesize MarketEod;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"MarketEod"]) return [CIAPIMarketEod class];
  return nil;
}

@end

