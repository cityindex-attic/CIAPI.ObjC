//
//  CIAPIGetNewsDetailRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetNewsDetailRequest.h"
#import "CIAPIGetNewsDetailResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize storyId;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"storyId", storyId, nil];
}

- (NSString*)urlTemplate
{
    return @"news/{storyId}";
}

- (Class)responseClass
{
    return [CIAPIGetNewsDetailResponse class];
}

@end

