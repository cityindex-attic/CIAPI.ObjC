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
//#import "RestKit/Support/RKJSONParser.h"

@implementation CIAPIClient

@synthesize username;
@synthesize sessionID;

- (CIAPIClient*)initWithUsername:(NSString*)_username sessionID:(NSString*)_sessionID
{
    self = [super init];
    
    if (self)
    {
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
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    RKResponse *response = [rkRequest sendSynchronously];
    
    if ([response isOK])
    {
        id bodyObj = [response bodyAsJSON];
        NSLog(@"Succeeded request: Target URL was %@, body is %@", response.URL, bodyObj);
        
        CIAPIObjectResponse *responseObj = [[[[request responseClass] alloc] init] autorelease];
        [responseObj setupFromDictionary:bodyObj error:nil];
        
        return responseObj;
    }
    else
    {
        // Is this an error object, or just an explosion?
        NSLog(@"Failed request: Target URL was %@, body is %@", response.URL, [response bodyAsString]);
    }
    
    return nil;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate error:(NSError**)error
{
    CIAPIRequestToken *requestToken = [[CIAPIRequestToken alloc] initWithRequest:request delegate:delegate];
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    
    if (!rkRequest)
        return nil;
    
    [requestToken setRKRequest:rkRequest];
    
    [requestDispatcher scheduleRequestToken:requestToken];
    
    return requestToken;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request block:(CIAPIRequestCallback)callbackBlock error:(NSError**)error
{
    CIAPIRequestToken *requestToken = [[CIAPIRequestToken alloc] initWithRequest:request block:[callbackBlock retain]];
    
    RKRequest *rkRequest = [self buildRKRequestFromCIAPIRequest:request error:error];
    
    if (!rkRequest)
        return nil;
    
    [requestToken setRKRequest:rkRequest];
    
    [requestDispatcher scheduleRequestToken:requestToken];
    
    return requestToken;
}

- (enum CIAPIRequestCancellationResult)cancelRequest:(CIAPIRequestToken*)token
{
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
