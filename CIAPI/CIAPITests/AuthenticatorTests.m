//
//  AuthenticatorTests.m
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthenticatorTests.h"

#import "CIAPI.h"


@implementation AuthenticatorTests

- (void)testAuthenticate
{
    CIAPIAuthenticator *auth = [[CIAPIAuthenticator alloc] init];
    
    [auth authenticateWithUserName:@"DM189301" password:@"password" error:nil];
}

@end
