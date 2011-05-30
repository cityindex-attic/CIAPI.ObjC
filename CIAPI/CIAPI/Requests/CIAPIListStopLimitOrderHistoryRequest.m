//
//  CIAPIListStopLimitOrderHistoryRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListStopLimitOrderHistoryRequest.h"

#import "CIAPIListStopLimitOrderHistoryResponse.h"

@implementation CIAPIListStopLimitOrderHistoryRequest

@synthesize tradingAccountId;
@synthesize maxResults;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"order/order/stoplimitorderhistory?TradingAccountId={tradingAccountId}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListStopLimitOrderHistoryResponse class];
}

@end

