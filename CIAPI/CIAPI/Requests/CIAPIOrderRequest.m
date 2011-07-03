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



- (CIAPIOrderRequest*)initWithOrderId:(NSInteger)_OrderId marketId:(NSInteger)_MarketId currency:(NSString*)_Currency autoRollover:(BOOL)_AutoRollover direction:(NSString*)_Direction quantity:(double)_Quantity bidPrice:(double)_BidPrice offerPrice:(double)_OfferPrice auditId:(NSString*)_AuditId tradingAccountId:(NSInteger)_TradingAccountId ifDone:(NSArray*)_IfDone ocoOrder:(CIAPINewStopLimitOrderRequest*)_OcoOrder applicability:(NSString*)_Applicability expiryDateTimeUTC:(NSString*)_ExpiryDateTimeUTC guaranteed:(BOOL)_Guaranteed triggerPrice:(double)_TriggerPrice{
  self = [super init];

  if (self)
  {
    self.OrderId = _OrderId;
    self.MarketId = _MarketId;
    self.Currency = _Currency;
    self.AutoRollover = _AutoRollover;
    self.Direction = _Direction;
    self.Quantity = _Quantity;
    self.BidPrice = _BidPrice;
    self.OfferPrice = _OfferPrice;
    self.AuditId = _AuditId;
    self.TradingAccountId = _TradingAccountId;
    self.IfDone = _IfDone;
    self.OcoOrder = _OcoOrder;
    self.Applicability = _Applicability;
    self.ExpiryDateTimeUTC = _ExpiryDateTimeUTC;
    self.Guaranteed = _Guaranteed;
    self.TriggerPrice = _TriggerPrice;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction
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

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

- (NSString*)throttleScope
{
    return @"trading";
}


@end

