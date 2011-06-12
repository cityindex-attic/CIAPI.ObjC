//
//  CIAPIListNewsHeadlinesRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIListNewsHeadlinesRequest.h"

#import "CIAPIListNewsHeadlinesResponse.h"

@implementation CIAPIListNewsHeadlinesRequest

@synthesize category;
@synthesize maxResults;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"news?Category={category}&MaxResults={maxResults}";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIListNewsHeadlinesResponse class];
}

@end

