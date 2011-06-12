//
//  CIAPIOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIOrderRequest.h"

#import "CIAPIIfDone.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIOrderRequest

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

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"order/newstoplimitorder";
}

- (NSString*)throttleScope
{
    return @"trading";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

