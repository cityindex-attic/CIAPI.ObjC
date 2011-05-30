//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIAccountInformationResponse : CIAPIObjectResponse {
  NSString* LogonUserName;
  NSInteger ClientAccountId;
  NSString* ClientAccountCurrency;
  NSArray* TradingAccounts;
}

// logon user name. 
@property (readonly) NSString* LogonUserName;
// client account id. 
@property (readonly) NSInteger ClientAccountId;
// Base currency of the client account. 
@property (readonly) NSString* ClientAccountCurrency;
// a list of trading accounts. 
@property (readonly) NSArray* TradingAccounts;

@end
