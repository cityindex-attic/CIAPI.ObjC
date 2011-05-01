//
//  CIAPIAccountInformationResponse.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIAccountInformationResponse.h"
#import "CIAPITradingAccount.h"

@implementation CIAPIAccountInformationResponse

@synthesize LogonUserName;
@synthesize ClientAccountId;
@synthesize ClientAccountCurrency;
@synthesize TradingAccounts;

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error
{
    LogonUserName = [[dictionary objectForKey:@"LogonUserName"] retain];
    ClientAccountId = [[dictionary objectForKey:@"LogonUserName"] intValue];
    ClientAccountCurrency = [[dictionary objectForKey:@"ClientAccountCurrency"] retain];
    
    NSMutableArray *tradingAccounts = [[NSMutableArray array] retain];
    
    for (id accountDict in [dictionary objectForKey:@"TradingAccounts"])
    {
        CIAPITradingAccount *account = [[CIAPITradingAccount alloc] init];
        [account setupFromDictionary:accountDict error:nil];
        
        [tradingAccounts addObject:account];
    }
    
    TradingAccounts = tradingAccounts;
    
    if (error)
        *error = nil;
    return YES;
}

@end
