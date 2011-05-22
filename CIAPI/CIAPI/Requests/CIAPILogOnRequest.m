//
//  CIAPILogOnRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPILogOnRequest.h"
#import "CIAPILogOnResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize UserName;
@synthesize Password;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"UserName", UserName,  @"Password", Password, nil];
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

