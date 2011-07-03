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



- (CIAPIListStopLimitOrderHistoryRequest*)initWithTradingAccountId:(NSInteger)_tradingAccountId maxResults:(NSInteger)_maxResults{
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
    return @"order/order/stoplimitorderhistory?TradingAccountId={tradingAccountId}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListStopLimitOrderHistoryResponse class];
}



@end

