//
//  CIAPIAccountInformationResponse.h
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIAccountInformationResponse : CIAPIObjectResponse {
    NSString *LogonUserName;
    int ClientAccountId;
    NSString *ClientAccountCurrency;
    NSArray *TradingAccounts;
}

@property (readonly) NSString *LogonUserName;
@property (readonly) int ClientAccountId;
@property (readonly) NSString *ClientAccountCurrency;
@property (readonly) NSArray *TradingAccounts;

@end
