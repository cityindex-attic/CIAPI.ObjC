//
//  CIAPITradeRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPITradeRequest.h"

#import "CIAPIIfDone.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPITradeRequest

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

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"order/newtradeorder";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

