//
//  CIAPIGenerateExceptionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGenerateExceptionRequest.h"

#import "CIAPIErrorResponse.h"

@implementation CIAPIGenerateExceptionRequest

@synthesize errorCode;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
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

