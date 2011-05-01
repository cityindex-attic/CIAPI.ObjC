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
    
    NSString *url = RKMakePathWithObject([request urlTemplate], [request propertiesForRequest]);
    RKRequest *rkRequest = [underlyingClient requestWithResourcePath:url delegate:nil];
    
    if ([request requestType] == CIAPIRequestGET)
    {
        rkRequest.method = RKRequestMethodGET;
    }
    else if ([request requestType] == CIAPIRequestPOST)
    {
        rkRequest.method = RKRequestMethodPOST;
        rkRequest.params = [RKJSONSerialization JSONSerializationWithObject:[request propertiesForRequest]];
    }
    else
    {
        assert(FALSE);
    }
    
    RKResponse *response = [rkRequest sendSynchronously];
    
    if ([response isOK])
    {
        id bodyObj = [response bodyAsJSON];
        
        CIAPIObjectResponse *responseObj = [[[request responseClass] alloc] init];
        [responseObj setupFromDictionary:bodyObj error:nil];
        
        return responseObj;
    }
    else
    {
        // Is this an error object, or just an explosion?
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

@end
