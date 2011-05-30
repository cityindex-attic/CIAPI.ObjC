//
//  CIAPIDeleteSessionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIDeleteSessionRequest.h"

#import "CIAPILogOffResponse.h"

@implementation CIAPIDeleteSessionRequest

@synthesize userName;
@synthesize session;


- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
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

