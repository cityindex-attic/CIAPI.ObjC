//
//  CIAPIGetChartingEnabledRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetChartingEnabledRequest.h"
#import "CIAPIBoolean.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize id;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"id", id, nil];
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/{id}/ChartingEnabled";
}

- (Class)responseClass
{
    return [CIAPIBoolean class];
}

@end

