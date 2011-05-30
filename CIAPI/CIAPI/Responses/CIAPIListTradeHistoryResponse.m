//
//  CIAPIListTradeHistoryResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListTradeHistoryResponse.h"

#import "CIAPITradeHistory.h"


@implementation CIAPIListTradeHistoryResponse 

@synthesize TradeHistory;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"TradeHistory"]) return [CIAPITradeHistory class];
  return nil;
}

@end

