//
//  CIAPIListMarketInformationSearchRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationSearchRequest.h"

#import "CIAPIListMarketInformationSearchResponse.h"

@implementation CIAPIListMarketInformationSearchRequest

@synthesize searchByMarketCode;
@synthesize searchByMarketName;
@synthesize spreadProductType;
@synthesize cfdProductType;
@synthesize binaryProductType;
@synthesize query;
@synthesize maxResults;



- (CIAPIListMarketInformationSearchRequest*)initWithSearchByMarketCode:(BOOL)_searchByMarketCode searchByMarketName:(BOOL)_searchByMarketName spreadProductType:(BOOL)_spreadProductType cfdProductType:(BOOL)_cfdProductType binaryProductType:(BOOL)_binaryProductType query:(NSString*)_query maxResults:(NSInteger)_maxResults{
  self = [super init];

  if (self)
  {
    self.searchByMarketCode = _searchByMarketCode;
    self.searchByMarketName = _searchByMarketName;
    self.spreadProductType = _spreadProductType;
    self.cfdProductType = _cfdProductType;
    self.binaryProductType = _binaryProductType;
    self.query = _query;
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
    return @"market/market/informationsearch?SearchByMarketCode={searchByMarketCode}&SearchByMarketName={searchByMarketName}&SpreadProductType={spreadProductType}&CfdProductType={cfdProductType}&BinaryProductType={binaryProductType}&Query={query}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListMarketInformationSearchResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

