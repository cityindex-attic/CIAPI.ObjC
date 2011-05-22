//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIAccountInformationResponse : CIAPIObjectResponse {
  id LogonUserName;
  id ClientAccountId;
  id ClientAccountCurrency;
  id TradingAccounts;
}

// logon user name. 
@property (readonly) id LogonUserName;
// client account id. 
@property (readonly) id ClientAccountId;
// Base currency of the client account. 
@property (readonly) id ClientAccountCurrency;
// a list of trading accounts. 
@property (readonly) id TradingAccounts;

@end
