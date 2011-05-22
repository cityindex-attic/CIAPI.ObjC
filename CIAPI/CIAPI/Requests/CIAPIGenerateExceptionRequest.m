//
//  CIAPIGenerateExceptionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGenerateExceptionRequest.h"
#import "CIAPIErrorResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize errorCode;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"errorCode", errorCode, nil];
}

- (NSString*)urlTemplate
{
    return @"errors?errorCode={errorCode}";
}

- (Class)responseClass
{
    return [CIAPIErrorResponse class];
}

@end

