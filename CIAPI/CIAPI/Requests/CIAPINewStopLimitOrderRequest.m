//
//  CIAPINewStopLimitOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPINewStopLimitOrderRequest.h"

#import "CIAPIIfDone.h"


@implementation CIAPINewStopLimitOrderRequest 

@synthesize OrderId;
@synthesize MarketId;
@synthesize Currency;
@synthesize AutoRollover;
@synthesize Direction;
@synthesize Quantity;
@synthesize BidPrice;
@synthesize OfferPrice;
@synthesize AuditId;
@synthesize TradingAccountId;
@synthesize IfDone;
@synthesize OcoOrder;
@synthesize Applicability;
@synthesize ExpiryDateTimeUTC;
@synthesize Guaranteed;
@synthesize TriggerPrice;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"IfDone"]) return [CIAPIIfDone class];
  return nil;
}

@end

