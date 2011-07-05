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
@synthesize successBlock;
@synthesize failureBlock;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        client = nil;
    }
    
    return self;
}


- (id)initWithDelegate:(id<CIAPIAuthenticatorDelegate>)_delegate
{
    self = [super init];
    
    if (self)
    {
        client = nil;
        delegate = _delegate;
    }
    
    return self;
}

- (id)initWithSuccessBlock:(CIAPIAuthenticatorSuccessCallback)_successBlock failureBlock:(CIAPIAuthenticatorFailureCallback)_failureBlock;
{
    self = [super init];
    
    if (self)
    {
        client = nil;
        self.successBlock = _successBlock;
        self.failureBlock = _failureBlock;
    }
    
    return self;
}

- (void)dealloc
{
    [client release];

    [successBlock release];
    [failureBlock release];

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
    
    urlConnection = [[CIAPIURLConnection CIAPIURLConnectionForRequest:request delegate:self] retain];
    [urlConnection start];
}

- (void)requestSucceeded:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response data:(NSData*)data
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication GOOD response recieved");
    
    NSError *error = nil;
    
    if ([self _setupClientOrError:response withData:data error:&error])
    {
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication SUCCEEDED");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(authenticationSucceeded:client:)])
                [delegate authenticationSucceeded:self client:client];
            
            if (successBlock)
                successBlock(self, client);            
        });
    }
    else
    {   
        // TODO: Pass proper error        
        CIAPILogAbout(CIAPILogLevelWarn, CIAPIAuthenticationModule, self, @"Authentication FAILURE");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(authenticationFailed:error:)])
                [delegate authenticationFailed:self error:error];
            
            if (failureBlock)
                failureBlock(self, error);            
        });
    }
    
    [urlConnection release];
    urlConnection = nil;
}

- (void)requestFailed:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIAuthenticationModule, self, @"Asynchronous authentication ERROR response recieved");

    // TODO: Look at the memory management of this - something not quite right
    dispatch_async(dispatch_get_main_queue(), ^{
        if (delegate && [delegate respondsToSelector:@selector(authenticationFailed:error:)])
        {
            [delegate authenticationFailed:self error:[NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorAuthenticationFailed userInfo:[NSDictionary dictionaryWithObject:CIAPILogGetForObject(self) forKey:CIAPI_ERROR_LOG]]];
        }
        
        if (failureBlock)
            failureBlock(self, error);
    });
    
    [urlConnection release];
    urlConnection = nil;
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
