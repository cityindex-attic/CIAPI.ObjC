//
//  CIAPIListMarketInformationSearchRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListMarketInformationSearchRequest.h"
#import "CIAPIListMarketInformationSearchResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize searchByMarketCode;
@synthesize searchByMarketName;
@synthesize spreadProductType;
@synthesize cfdProductType;
@synthesize binaryProductType;
@synthesize query;
@synthesize maxResults;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"searchByMarketCode", searchByMarketCode,  @"searchByMarketName", searchByMarketName,  @"spreadProductType", spreadProductType,  @"cfdProductType", cfdProductType,  @"binaryProductType", binaryProductType,  @"query", query,  @"maxResults", maxResults, nil];
}

- (NSString*)urlTemplate
{
    return @"market/market/informationsearch?SearchByMarketCode={searchByMarketCode}&SearchByMarketName={searchByMarketName}&SpreadProductType={spreadProductType}&CfdProductType={cfdProductType}&BinaryProductType={binaryProductType}&Query={query}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListMarketInformationSearchResponse class];
}

@end

