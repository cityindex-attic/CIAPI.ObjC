//
//  CIAPIListNewsHeadlinesRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListNewsHeadlinesRequest.h"
#import "CIAPIListNewsHeadlinesResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize category;
@synthesize maxResults;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"category", category,  @"maxResults", maxResults, nil];
}

- (NSString*)urlTemplate
{
    return @"news?Category={category}&MaxResults={maxResults}";
}

- (Class)responseClass
{
    return [CIAPIListNewsHeadlinesResponse class];
}

@end

