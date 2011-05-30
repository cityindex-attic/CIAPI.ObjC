//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPITradingAccount : CIAPIObjectResponse {
  NSInteger TradingAccountId;
  NSString* TradingAccountCode;
  NSString* TradingAccountStatus;
  NSString* TradingAccountType;
}

// Trading Account Id 
@property (readonly) NSInteger TradingAccountId;
// Trading Account Code 
@property (readonly) NSString* TradingAccountCode;
// Trading Account Status 
@property (readonly) NSString* TradingAccountStatus;
// Trading Account Type 
@property (readonly) NSString* TradingAccountType;

@end
