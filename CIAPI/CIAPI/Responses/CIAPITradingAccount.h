//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPITradingAccount : NSObject {
  id TradingAccountId;
  id TradingAccountCode;
  id TradingAccountStatus;
  id TradingAccountType;
}

// Trading Account Id 
@property (readonly) id TradingAccountId;
// Trading Account Code 
@property (readonly) id TradingAccountCode;
// Trading Account Status 
@property (readonly) id TradingAccountStatus;
// Trading Account Type 
@property (readonly) id TradingAccountType;

@end
