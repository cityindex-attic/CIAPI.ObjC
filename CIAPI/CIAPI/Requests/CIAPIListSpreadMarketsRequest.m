//
//  CIAPIListSpreadMarketsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListSpreadMarketsRequest.h"

#import "CIAPIListSpreadMarketsResponse.h"

@implementation CIAPIListSpreadMarketsRequest

@synthesize searchByMarketName;
@synthesize searchByMarketCode;
@synthesize clientAccountId;
@synthesize maxResults;



- (CIAPIListSpreadMarketsRequest*)initWithSearchByMarketName:(NSString*)_searchByMarketName searchByMarketCode:(NSString*)_searchByMarketCode clientAccountId:(NSInteger)_clientAccountId{
  self = [super init];

  if (self)
  {
    self.searchByMarketName = _searchByMarketName;
    self.searchByMarketCode = _searchByMarketCode;
    self.clientAccountId = _clientAccountId;
    self.maxResults = 20;
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
    return @"spread/markets?MarketName={searchByMarketName}&MarketCode={searchByMarketCode}&ClientAccountId={clientAccountId}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListSpreadMarketsResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}

- (NSTimeInterval)cacheDuration
{
  return 10.0;
}

@end

