//
//  CIAPIListTradeHistoryRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListTradeHistoryRequest.h"
#import "CIAPIListTradeHistoryResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize tradingAccountId;
@synthesize maxResults;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"tradingAccountId", tradingAccountId,  @"maxResults", maxResults, nil];
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

