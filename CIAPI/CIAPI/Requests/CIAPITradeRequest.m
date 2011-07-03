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



- (CIAPITradeRequest*)initWithMarketId:(NSInteger)_MarketId currency:(NSString*)_Currency autoRollover:(BOOL)_AutoRollover direction:(NSString*)_Direction quantity:(double)_Quantity quoteId:(NSString*)_QuoteId bidPrice:(double)_BidPrice offerPrice:(double)_OfferPrice auditId:(NSString*)_AuditId tradingAccountId:(NSInteger)_TradingAccountId ifDone:(NSArray*)_IfDone close:(NSArray*)_Close{
  self = [super init];

  if (self)
  {
    self.MarketId = _MarketId;
    self.Currency = _Currency;
    self.AutoRollover = _AutoRollover;
    self.Direction = _Direction;
    self.Quantity = _Quantity;
    self.QuoteId = _QuoteId;
    self.BidPrice = _BidPrice;
    self.OfferPrice = _OfferPrice;
    self.AuditId = _AuditId;
    self.TradingAccountId = _TradingAccountId;
    self.IfDone = _IfDone;
    self.Close = _Close;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction
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

- (NSString*)throttleScope
{
    return @"trading";
}


@end

