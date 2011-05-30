//
//  CIAPIListActiveStopLimitOrderResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListActiveStopLimitOrderResponse.h"

#import "CIAPIActiveStopLimitOrder.h"


@implementation CIAPIListActiveStopLimitOrderResponse 

@synthesize ActiveStopLimitOrders;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"ActiveStopLimitOrders"]) return [CIAPIActiveStopLimitOrder class];
  return nil;
}

@end

