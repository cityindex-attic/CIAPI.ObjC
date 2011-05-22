//
//  CIAPIOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIOrderRequest.h"
#import "CIAPITradeOrderResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

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

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"OrderId", OrderId,  @"MarketId", MarketId,  @"Currency", Currency,  @"AutoRollover", AutoRollover,  @"Direction", Direction,  @"Quantity", Quantity,  @"BidPrice", BidPrice,  @"OfferPrice", OfferPrice,  @"AuditId", AuditId,  @"TradingAccountId", TradingAccountId,  @"IfDone", IfDone,  @"OcoOrder", OcoOrder,  @"Applicability", Applicability,  @"ExpiryDateTimeUTC", ExpiryDateTimeUTC,  @"Guaranteed", Guaranteed,  @"TriggerPrice", TriggerPrice, nil];
}

- (NSString*)urlTemplate
{
    return @"order/newstoplimitorder";
}

- (Class)responseClass
{
    return [CIAPITradeOrderResponse class];
}

@end

