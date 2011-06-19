//
//  CIAPIAuthenticator.m
//  CIAPI
//
//  Created by Adam Wright on 08/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RestKit/RestKit.h"

#import "CIAPIAuthenticator.h"
#import "CIAPIConfigConstants.h"

#import "Requests/CIAPILogOnRequest.h"
#import "Responses/CIAPILogOnResponse.h"

@implementation CIAPIAuthenticator

@synthesize client;

@synthesize delegate;
@synthesize block;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        rkClient = [[RKClient clientWithBaseURL:CIAPI_BASE_URI] retain];
        client = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [client release];
    [rkClient release];
    [request cancel];
    [request release];
    [block release];

    [super dealloc];
}

- (BOOL)authenticateWithUserNameSynchronously:(NSString*)userName password:(NSString*)password error:(NSError**)error;
{
    request = [self _buildRequestWithUsername:userName password:password];    
    RKResponse *response = [request sendSynchronously];
    
    BOOL result = [self _setupClientOrError:response error:error];
    
    [request release];
        
    return result;
}

- (void)authenticateWithUserName:(NSString*)userName password:(NSString*)password
{
    [request cancel];
    [request release];
    
    request = [self _buildRequestWithUsername:userName password:password];
    [request send];
}

- (void)request:(RKRequest*)_request didLoadResponse:(RKResponse*)response
{
    NSError *error = nil;
    
    if (![self _setupClientOrError:response error:&error])
    {
        if (delegate)
            [delegate authenticationFailed:self error:error];
        
        if (block)
            block(self, error);
    }
    else
    {    
        if (delegate)
            [delegate authenticationSucceeded:self];
        
        if (block)
            block(self, nil);
    }
    
    [request release];
    request = nil;
}

- (void)request:(RKRequest*)_request didFailLoadWithError:(NSError*)error
{
    if (delegate)
        [delegate authenticationFailed:self error:error];
    
    if (block)
        block(self, error);
    
    [request release];
    request = nil;
}

- (RKRequest*)_buildRequestWithUsername:(NSString*)userName password:(NSString*)password
{
    CIAPILogOnRequest *loRequest = [[[CIAPILogOnRequest alloc] init] autorelease];
    loRequest.UserName = userName;
    loRequest.Password = password;
    
    request = [[rkClient requestWithResourcePath:@"session" delegate:self] retain];
    [request setMethod:RKRequestMethodPOST];
    [request setParams:[RKJSONSerialization JSONSerializationWithObject:[loRequest propertiesForRequest]]];
    
    // A little bit hacky to carry information in the request, but good enough to get off the ground prototyping with
    [request setUserData: userName];
    
    return request;
}

- (BOOL)_setupClientOrError:(RKResponse*)response error:(NSError**)error
{
    id bodyObj = [response bodyAsJSON];
    NSString *sessionID = [bodyObj objectForKey:@"Session"];
    
    if (bodyObj == nil || sessionID == nil)
    {
        // TODO: Setup errors properly
        if (error)
            *error = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
        
        return FALSE;
    }
    
    [client release];
    client = [[CIAPIClient alloc] initWithUsername:response.request.userData sessionID:sessionID];

    return YES;
}


@end
