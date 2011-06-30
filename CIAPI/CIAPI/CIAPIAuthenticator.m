//
//  CIAPIAuthenticator.m
//  CIAPI
//
//  Created by Adam Wright on 08/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSONKit.h"

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
        client = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [client release];

    [block release];

    [super dealloc];
}

- (BOOL)authenticateWithUserNameSynchronously:(NSString*)userName password:(NSString*)password error:(NSError**)error;
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Authenticating client %@ synchronously", userName);
    NSURLRequest *urlRequest = [self _buildRequestWithUsername:userName password:password];    
    
    NSHTTPURLResponse *urlResponse;
    NSData *responseData = [CIAPIURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:error];
        
    return [self _setupClientOrError:urlResponse withData:responseData error:error];
}

- (void)authenticateWithUserName:(NSString*)userName password:(NSString*)password
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Authenticating client %@ asynchronously", userName);
    
    [urlConnection cancel];
    [urlConnection release];
    
    NSURLRequest *request = [self _buildRequestWithUsername:userName password:password];
    
    urlConnection = [CIAPIURLConnection CIAPIURLConnectionForRequest:request delegate:self];
    [urlConnection start];
}

- (void)requestSucceeded:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response data:(NSData*)data
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication GOOD response recieved");
    
    NSError *error = nil;
    
    if (![self _setupClientOrError:response withData:data error:&error])
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

- (void)requestFailed:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication ERROR response recieved");
    
    if (delegate)
        [delegate authenticationFailed:self error:[NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorAuthenticationFailed userInfo:[NSDictionary dictionaryWithObject:CIAPILogGetForObject(self) forKey:CIAPI_ERROR_LOG]]];
    
    if (block)
        block(self, error);
    
    [request release];
    request = nil;
}

- (NSURLRequest*)_buildRequestWithUsername:(NSString*)userName password:(NSString*)password
{    
    CIAPILogOnRequest *loRequest = [[[CIAPILogOnRequest alloc] init] autorelease];
    loRequest.UserName = userName;
    loRequest.Password = password;

    NSURL *sessionURl = [NSURL URLWithString:@"session" relativeToURL:CIAPI_BASE_URL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:sessionURl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:CIAPI_REQUEST_TIMEOUT_LENGTH];
    
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [urlRequest setHTTPBody:[[loRequest propertiesForRequest] JSONData]];

    lastUsername = [userName retain];
    
    return urlRequest;
}

- (BOOL)_setupClientOrError:(NSHTTPURLResponse*)response withData:(NSData*)data error:(NSError**)error
{
    id bodyObj = [data objectFromJSONData];
    NSString *sessionID = [bodyObj objectForKey:@"Session"];
    
    if (bodyObj == nil || sessionID == nil)
    {
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication response INCORRECT: Reply was %@",
                      [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
        if (error)
            *error = [NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorAuthenticationFailed userInfo:CIAPILogErrorDictForObject(self)];
        
        return FALSE;
    }
    
    [client release];
    client = [[CIAPIClient alloc] initWithUsername:lastUsername sessionID:sessionID];

    return YES;
}


@end
