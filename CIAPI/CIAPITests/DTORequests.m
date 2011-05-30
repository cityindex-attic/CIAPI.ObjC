//
//  DTORequests.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DTORequests.h"
#import "CIAPIAuthenticator.h"


#import "CIAPIGetClientAndTradingAccountRequest.h"
#import "CIAPIAccountInformationResponse.h"
#import "CIAPITradingAccount.h"

#import "CIAPIListNewsHeadlinesRequest.h"
#import "CIAPIListNewsHeadlinesResponse.h"

@implementation DTORequests

- (void) setUp
{
#if TEST_REQUESTS
    CIAPIAuthenticator *authenticator = [[CIAPIAuthenticator alloc] init];
    [authenticator authenticateWithUserNameSynchronously:@"DM189301" password:@"password" error:nil];
    
    client = [authenticator.client retain];
    
    [authenticator release];
#endif
}

- (void) tearDown
{
#if TEST_REQUESTS
    [client release];
#endif
}

#if TEST_REQUESTS

- (void)testAccountInformation
{
    STAssertNotNil(client, @"Client setup must have failed");
    
    CIAPIGetClientAndTradingAccountRequest *request = [[CIAPIGetClientAndTradingAccountRequest alloc] init];    
    CIAPIAccountInformationResponse *resp = [client makeRequest:request error:nil];
    
    STAssertNotNil(resp, @"Response should not be nil");
    
    STAssertEquals(resp.ClientAccountId, 400133748, @"Client account id should be 400133748"); 
    STAssertEqualObjects(resp.ClientAccountCurrency, @"GBP", @"Client currency should be GBP");
    
    STAssertEquals((int)[resp.TradingAccounts count], 2, @"The account should have 2 associated trading accounts");
    STAssertEqualObjects([[resp.TradingAccounts objectAtIndex:1] TradingAccountCode], @"DM354556", @"The second account should be this code");
}

- (void)testNewsHeadlines
{
    STAssertNotNil(client, @"Client setup must have failed");
    
    CIAPIListNewsHeadlinesRequest *request = [[CIAPIListNewsHeadlinesRequest alloc] init];
    request.category = @"uk";
    request.maxResults = 20;
    CIAPIListNewsHeadlinesResponse *resp = [client makeRequest:request error:nil];
    
    STAssertNotNil(resp, @"Response should not be nil");
    STAssertEquals([resp count], (NSUInteger)20, @"There really should be 20 UK news stories!"); 
}

#endif

@end
