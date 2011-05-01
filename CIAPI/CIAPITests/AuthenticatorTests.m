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

- (void)testSynchronousAuthentication
{
    CIAPIAuthenticator *auth = [[CIAPIAuthenticator alloc] init];
    
    [auth authenticateWithUserNameSynchronously:@"DM189301" password:@"password" error:nil];
    
    STAssertNotNil(auth.client, @"Client should not be nil after good synchronous authentication!");
}

@end
