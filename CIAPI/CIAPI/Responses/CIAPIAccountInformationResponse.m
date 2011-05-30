//
//  CIAPIAccountInformationResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIAccountInformationResponse.h"

#import "CIAPITradingAccount.h"


@implementation CIAPIAccountInformationResponse 

@synthesize LogonUserName;
@synthesize ClientAccountId;
@synthesize ClientAccountCurrency;
@synthesize TradingAccounts;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"TradingAccounts"]) return [CIAPITradingAccount class];
  return nil;
}

@end

