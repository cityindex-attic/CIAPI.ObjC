//
//  CIAPIGetChartingEnabledRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetChartingEnabledRequest.h"


@implementation CIAPIGetChartingEnabledRequest

@synthesize ident;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/{id}/ChartingEnabled";
}

- (Class)responseClass
{
    return [NSNumber class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

