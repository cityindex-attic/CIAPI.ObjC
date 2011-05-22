//
//  CIAPITradeRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPITradeRequest.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

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

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"MarketId", MarketId,  @"Currency", Currency,  @"AutoRollover", AutoRollover,  @"Direction", Direction,  @"Quantity", Quantity,  @"QuoteId", QuoteId,  @"BidPrice", BidPrice,  @"OfferPrice", OfferPrice,  @"AuditId", AuditId,  @"TradingAccountId", TradingAccountId,  @"IfDone", IfDone,  @"Close", Close, nil];
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

