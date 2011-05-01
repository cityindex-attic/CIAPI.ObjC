//
//  CIAPITradingAccount.h
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPITradingAccount : CIAPIObjectResponse {
    int TradingAccountId;
    NSString *TradingAccountCode;
    NSString *TradingAccountStatus;
    NSString *TradingAccountType;
}

@property (readonly) int TradingAccountId;
@property (readonly) NSString *TradingAccountCode;
@property (readonly) NSString *TradingAccountStatus;
@property (readonly) NSString *TradingAccountType;

@end
