//
//  CIAPILogOnRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPILogOnRequest.h"

#import "CIAPILogOnResponse.h"

@implementation CIAPILogOnRequest

@synthesize UserName;
@synthesize Password;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"session/";
}

- (Class)responseClass
{
    return [CIAPILogOnResponse class];
}

@end

