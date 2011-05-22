//
//  CIAPIDeleteSessionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIDeleteSessionRequest.h"
#import "CIAPILogOffResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

@synthesize userName;
@synthesize session;

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionaryWithObjects:  @"userName", userName,  @"session", session, nil];
}

- (NSString*)urlTemplate
{
    return @"session/deleteSession?userName={userName}&session={session}";
}

- (Class)responseClass
{
    return [CIAPILogOffResponse class];
}

@end

