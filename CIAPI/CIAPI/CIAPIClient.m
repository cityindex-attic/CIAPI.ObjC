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

#import "RestKit/Support/RKJSONParser.h"

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
        [underlyingClient.HTTPHeaders setValue:sessionID forKey:@"Session"];
        [underlyingClient.HTTPHeaders setValue:username forKey:@"UserName"];
    }
    
    return self;
}

- (void)dealloc
{
    [underlyingClient release];
    [username release];
    [sessionID release];
    
    [super dealloc];
}

- (id)makeRequest:(CIAPIObjectRequest*)request error:(NSError**)error
{
    assert(request != nil);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[request propertiesForRequest]];
    // This call will mutable the parameters to consume the ones used in the URL. This covers POST requests that have URL parameters
    NSString *url = [self buildURLFromTemplate:[request urlTemplate] parameters:parameters error:nil];
    RKRequest *rkRequest = [underlyingClient requestWithResourcePath:url delegate:nil];
    
    if ([request requestType] == CIAPIRequestGET)
    {
        rkRequest.method = RKRequestMethodGET;
    }
    else if ([request requestType] == CIAPIRequestPOST)
    {
        rkRequest.method = RKRequestMethodPOST;
        rkRequest.params = [RKJSONSerialization JSONSerializationWithObject:parameters];
    }
    else
    {
        assert(FALSE);
    }
    
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

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate
{
    return nil;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request block:(CIAPIRequestCallback)delegate
{
    return nil;
}

- (enum CIAPIRequestCancellationResult)cancelRequest:(CIAPIRequestToken*)token
{
    return 0;
}

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate
{
    return NO;
}

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block
{
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel
{
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate
{
    return NO;
}

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block
{
    return NO;
}

/*
 * Private members
 */

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
