//
//  CIAPIGetTermsAndConditionsRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetTermsAndConditionsRequest.h"


@implementation CIAPIGetTermsAndConditionsRequest

@synthesize clientaccount;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/{clientaccount}/TermsAndConditions";
}

- (Class)responseClass
{
    return [NSString class];
}

@end

