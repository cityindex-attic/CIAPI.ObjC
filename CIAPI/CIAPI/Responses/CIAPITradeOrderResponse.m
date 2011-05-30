//
//  CIAPITradeOrderResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPITradeOrderResponse.h"

#import "CIAPIOrderResponse.h"


@implementation CIAPITradeOrderResponse 

@synthesize Status;
@synthesize StatusReason;
@synthesize OrderId;
@synthesize Orders;
@synthesize Quote;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"Orders"]) return [CIAPIOrderResponse class];
  return nil;
}

@end

