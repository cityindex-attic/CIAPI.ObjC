//
//  CIAPINewTradeOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPINewTradeOrderRequest.h"

#import "CIAPIIfDone.h"


@implementation CIAPINewTradeOrderRequest 

@synthesize MarketId;
@synthesize Currency;
@synthesize AutoRollover;
@synthesize Direction;
@synthesize Quantity;
@synthesize QuoteId;
@synthesize BidPrice;
@synthesize OfferPrice;
@synthesize AuditId;
@synthesize TradingAccountId;
@synthesize IfDone;
@synthesize Close;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"IfDone"]) return [CIAPIIfDone class];
  if ([name isEqualToString:@"Close"]) return [NSNumber class];
  return nil;
}

@end

