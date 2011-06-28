//
//  CIClient.m
//  CIAPI
//
//  Created by Adam Wright on 29/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "CIAPIConfigConstants.h"
#import "CIAPIClient.h"
#import "CIAPIObjectResponse.h"

#import "RestKit/RestKit.h"


#import "CIAPILogging.h"

@implementation CIAPIClient

@synthesize username;
@synthesize sessionID;

- (CIAPIClient*)initWithUsername:(NSString*)_username sessionID:(NSString*)_sessionID
{
    self = [super init];
    
    if (self)
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Initialising CIAPIClient with username %@ and session ID %@", _username, _sessionID);
        username = [_username retain];
        sessionID = [_sessionID retain];
        
        underlyingClient = [[RKClient clientWithBaseURL:CIAPI_BASE_URI] retain];
        [((RKClient*)underlyingClient).HTTPHeaders setValue:sessionID forKey:@"Session"];
        [((RKClient*)underlyingClient).HTTPHeaders setValue:username forKey:@"UserName"];
        
        requestDispatcher = [[RequestDispatcher alloc] init];
        
        [requestDispatcher startDispatcher];
    }
    
    return self;
}

- (void)dealloc
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Deallocating CIAPIClient");
    
    [requestDispatcher stopDispatcher];
    
    [requestDispatcher release];
    [underlyingClient release];
    [username release];
    [sessionID release];
    
    [super dealloc];
}

- (id)makeRequest:(CIAPIObjectRequest*)request error:(NSError**)error
{    
    assert(request != nil);

    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Begining synchronous request %@", request);    
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    RKResponse *response = [rkRequest sendSynchronously];
    
    if ([response isOK])
    {
        id bodyObj = [response bodyAsJSON];
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Synchronous request %X SUCCEEDED : Response = %@", request, bodyObj);
        
        CIAPIObjectResponse *responseObj = [[[[request responseClass] alloc] init] autorelease];
        [responseObj setupFromDictionary:bodyObj error:nil];
        
        return responseObj;
    }
    else
    {
        // Is this an error object, or just an explosion?
        CIAPILogAbout(CIAPILogLevelWarn, CIAPICoreClientModule, self, @"Synchronous request %X FAILED. Was to URL %@, Response = %@ ",
                      request, response.URL, [response bodyAsString]);
    }
    
    return nil;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate error:(NSError**)error
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asynchronous request %@ started, calling back to delegate %X", request, delegate);
    CIAPIRequestToken *requestToken = [[[CIAPIRequestToken alloc] initWithRequest:request delegate:delegate] autorelease];
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, requestToken, @"Request %@ created request token %X", request, requestToken);
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    
    if (!rkRequest)
        return nil;
    
    [requestToken setRKRequest:rkRequest];
    
    [requestDispatcher scheduleRequestToken:requestToken];
    
    return requestToken;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request block:(CIAPIRequestCallback)callbackBlock error:(NSError**)error
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asynchronous request %@ started, calling back to block %X", request, callbackBlock);
    CIAPIRequestToken *requestToken = [[[CIAPIRequestToken alloc] initWithRequest:request block:callbackBlock ] autorelease];
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, requestToken, @"Request %@ created request token %X", request, requestToken);
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    
    if (!rkRequest)
        return nil;
    
    [requestToken setRKRequest:rkRequest];
    
    [requestDispatcher scheduleRequestToken:requestToken];
    
    return requestToken;
}

- (enum CIAPIRequestCancellationResult)cancelRequest:(CIAPIRequestToken*)token
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, token, @"Started cancellation for request token %X", token);
    [requestDispatcher unscheduleRequestToken:token];
    
    return 0;
}

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate
{
    NSAssert(FALSE, @"Streams are not yet implemented, pending CI API changes");
    
    return NO;
}

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block
{
    NSAssert(FALSE, @"Streams are not yet implemented, pending CI API changes");
    
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel
{
    NSAssert(FALSE, @"Streams are not yet implemented, pending CI API changes");
    
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate
{
    NSAssert(FALSE, @"Streams are not yet implemented, pending CI API changes");
    
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block
{
    NSAssert(FALSE, @"Streams are not yet implemented, pending CI API changes");
    
    return NO;
}

/*
 * Private members
 */

- (RKRequest*)buildRKRequestFromCIAPIRequest:(CIAPIObjectRequest*)ciapiRequest error:(NSError**)error
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[ciapiRequest propertiesForRequest]];
    // This call will mutable the parameters to consume the ones used in the URL. This covers POST requests that have URL parameters
    NSString *url = [self buildURLFromTemplate:[ciapiRequest urlTemplate] parameters:parameters error:error];
    RKRequest *rkRequest = [underlyingClient requestWithResourcePath:url delegate:nil];
    
    if ([ciapiRequest requestType] == CIAPIRequestGET)
    {
        rkRequest.method = RKRequestMethodGET;
    }
    else if ([ciapiRequest requestType] == CIAPIRequestPOST)
    {
        rkRequest.method = RKRequestMethodPOST;
        rkRequest.params = [RKJSONSerialization JSONSerializationWithObject:parameters];
    }
    else
    {
        assert(FALSE);
    }
    
    return rkRequest;
}

// TODO: We don't really know which URL parameters are optional, so we require them all
- (NSString*)buildURLFromTemplate:(NSString*)urlTemplate parameters:(NSMutableDictionary*)parameters error:(NSError**)error
{
    NSScanner *scanner = [NSScanner scannerWithString:urlTemplate];
    NSMutableString *builtURL = [NSMutableString string];
    
    // Scan for pairs of { and }, which delimit replacement keys
    // Remove them from the string, and replace them with the parameter. Then remove the parameter from the dictionary
    NSString *token;

    while (![scanner isAtEnd])
    {
        if ([scanner scanUpToString:@"{" intoString:&token])
            [builtURL appendString:token];
        
        if ([scanner scanString:@"{" intoString:nil])
        {
            [scanner scanUpToString:@"}" intoString:&token];
            
            id paramValue = [parameters objectForKey:token];
            [parameters removeObjectForKey:token];
            
            if (!paramValue)
            {
                if (error != NULL)
                    *error = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
                return nil;
            }
            
            [builtURL appendFormat:@"%@", paramValue];
            
            if (![scanner scanString:@"}" intoString:nil] && error)
            {
                *error = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
                return nil;
            }
        }
    }
    
    return builtURL;
}

@end
