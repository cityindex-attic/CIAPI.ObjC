//
//  CIAPIGetClientAndTradingAccountRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetClientAndTradingAccountRequest.h"

#import "CIAPIAccountInformationResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest



- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/ClientAndTradingAccount";
}

- (NSString*)throttleScope
{
    return @"data";
}

- (Class)responseClass
{
    return [CIAPIAccountInformationResponse class];
}

@end

