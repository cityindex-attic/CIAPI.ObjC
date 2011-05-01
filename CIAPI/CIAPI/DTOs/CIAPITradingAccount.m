//
//  CIAPITradingAccount.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPITradingAccount.h"


@implementation CIAPITradingAccount

@synthesize TradingAccountId;
@synthesize TradingAccountCode;
@synthesize TradingAccountStatus;
@synthesize TradingAccountType;

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error
{
    TradingAccountId = [[dictionary objectForKey:@"TradingAccountId"] intValue];
    TradingAccountCode = [[dictionary objectForKey:@"TradingAccountCode"] retain];
    TradingAccountStatus = [[dictionary objectForKey:@"TradingAccountStatus"] retain];
    TradingAccountType = [[dictionary objectForKey:@"TradingAccountType"] retain];
    
    return YES;
}

@end
