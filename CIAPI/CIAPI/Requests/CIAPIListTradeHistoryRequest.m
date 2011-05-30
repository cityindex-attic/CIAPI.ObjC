//
//  CIAPIListTradeHistoryRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListTradeHistoryRequest.h"

#import "CIAPIListTradeHistoryResponse.h"

@implementation CIAPIListTradeHistoryRequest

@synthesize tradingAccountId;
@synthesize maxResults;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/order/tradehistory?TradingAccountId={tradingAccountId}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListTradeHistoryResponse class];
}

@end

