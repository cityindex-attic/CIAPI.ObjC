//
//  CIAPIGetTermsAndConditionsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetTermsAndConditionsRequest.h"
#import "CIAPIString.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize clientaccount;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"clientaccount", clientaccount, nil];
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/{clientaccount}/TermsAndConditions";
}

- (Class)responseClass
{
    return [CIAPIString class];
}

@end

