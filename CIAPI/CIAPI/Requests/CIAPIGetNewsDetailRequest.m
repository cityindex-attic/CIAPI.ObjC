//
//  CIAPIGetNewsDetailRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetNewsDetailRequest.h"

#import "CIAPIGetNewsDetailResponse.h"

@implementation CIAPIGetNewsDetailRequest

@synthesize storyId;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"news/{storyId}";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIGetNewsDetailResponse class];
}

@end

