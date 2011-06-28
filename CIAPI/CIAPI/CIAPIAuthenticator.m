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
#import "CIAPILogging.h"
#import "CIAPIErrorHandling.h"

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
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Authenticating client %@ synchronously", userName);
    request = [self _buildRequestWithUsername:userName password:password];    
    RKResponse *response = [request sendSynchronously];
    
    BOOL result = [self _setupClientOrError:response error:error];
    
    [request release];
        
    return result;
}

- (void)authenticateWithUserName:(NSString*)userName password:(NSString*)password
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Authenticating client %@ asynchronously", userName);
    
    [request cancel];
    [request release];
    
    request = [self _buildRequestWithUsername:userName password:password];
    [request send];
}

- (void)request:(RKRequest*)_request didLoadResponse:(RKResponse*)response
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication GOOD response recieved");
    
    NSError *error = nil;
    
    if (![self _setupClientOrError:response error:&error])
    {
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication FAILED");
        
        if (delegate)
            [delegate authenticationFailed:self error:error];
        
        if (block)
            block(self, error);
    }
    else
    {    
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication SUCCEEDED");
        
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
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication ERROR response recieved");
    
    if (delegate)
        [delegate authenticationFailed:self error:[NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorAuthenticationFailed userInfo:[NSDictionary dictionaryWithObject:CIAPILogGetForObject(self) forKey:CIAPI_ERROR_LOG]]];
    
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
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication response INCORRECT: Reply was %@", [response bodyAsString]);
        if (error)
            *error = [NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorAuthenticationFailed userInfo:CIAPILogErrorDictForObject(self)];
        
        return FALSE;
    }
    
    [client release];
    client = [[CIAPIClient alloc] initWithUsername:response.request.userData sessionID:sessionID];

    return YES;
}


@end
