//
//  GetClientAndTradingAccountRequest.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIGetClientAndTradingAccountRequest.h"

#import "CIAPIAccountInformationResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSDictionary*)propertiesForRequest
{
    return [NSDictionary dictionary];
}

- (NSString*)urlTemplate
{
    return @"/UserAccount/ClientAndTradingAccount";
}

- (Class)responseClass
{
    return [CIAPIAccountInformationResponse class];
}

@end
