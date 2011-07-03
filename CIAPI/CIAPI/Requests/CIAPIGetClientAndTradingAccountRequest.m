//
//  CIAPIGetClientAndTradingAccountRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetClientAndTradingAccountRequest.h"

#import "CIAPIAccountInformationResponse.h"

@implementation CIAPIGetClientAndTradingAccountRequest




// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/ClientAndTradingAccount";
}

- (Class)responseClass
{
    return [CIAPIAccountInformationResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

