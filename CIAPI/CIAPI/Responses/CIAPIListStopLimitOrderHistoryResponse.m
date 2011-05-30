//
//  CIAPIListStopLimitOrderHistoryResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListStopLimitOrderHistoryResponse.h"

#import "CIAPIStopLimitOrderHistory.h"


@implementation CIAPIListStopLimitOrderHistoryResponse 

@synthesize StopLimitOrderHistory;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"StopLimitOrderHistory"]) return [CIAPIStopLimitOrderHistory class];
  return nil;
}

@end

