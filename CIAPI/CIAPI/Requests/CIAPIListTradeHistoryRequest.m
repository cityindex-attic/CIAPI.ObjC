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



- (CIAPIListTradeHistoryRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId maxResults:(NSInteger)_maxResults{
  self = [super init];

  if (self)
  {
    self.tradingAccountId = _tradingAccountId;
    self.maxResults = _maxResults;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

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

