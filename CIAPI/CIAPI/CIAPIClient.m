//
//  CIClient.m
//  CIAPI
//
//  Created by Adam Wright on 29/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSONKit.h"

#import "CIAPIConfigConstants.h"
#import "CIAPIClient.h"
#import "CIAPIObjectResponse.h"
#import "CIAPILogging.h"
#import "CIAPIURLConnection.h"

@implementation CIAPIClient

@synthesize username;
@synthesize sessionID;
@synthesize dispatchQueue;

- (CIAPIClient*)initWithUsername:(NSString*)_username sessionID:(NSString*)_sessionID
{
    self = [super init];
    
    if (self)
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Initialising CIAPIClient with username %@ and session ID %@", _username, _sessionID);
        username = [_username retain];
        sessionID = [_sessionID retain];

        self.dispatchQueue = dispatch_get_main_queue();
        
        requestDispatcher = [[CIAPIRequestDispatcher alloc] initWithMaximumRetryAttempts:3 throttleSize:10 throttlePeriod:10.0];
        [requestDispatcher startDispatcher];
    }
    
    return self;
}

- (void)dealloc
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Deallocating CIAPIClient");
    
    [requestDispatcher stopDispatcher];
    
    [requestDispatcher release];
    [username release];
    [sessionID release];
    
    [super dealloc];
}

- (id)makeRequest:(CIAPIObjectRequest*)request error:(NSError**)error
{    
    NSAssert(request != nil, @"Cannot make a nil request");
    
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Begining synchronous request %@", request);        
    
    if ([requestCache hasCachedResponseForRequest:request])
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Synchronous request fulfilled by cache!");
        
        return [requestCache cachedResponseForRequest:request];
    }
    
    // TODO: Need to use API errors properly
    NSURLRequest *urlRequest = [self _buildURLRequestFromCIAPIRequest:request error:error];
    NSHTTPURLResponse *urlResponse = nil;
    
    NSData *resultData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:error];
    
    if ([urlResponse statusCode] == 200)
    {        
        id bodyObj = [[JSONDecoder decoder] objectWithData:resultData error:error];
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Synchronous request %X SUCCEEDED : Response = %@", request, bodyObj);
        
        CIAPIObjectResponse *responseObj = [[[[request responseClass] alloc] init] autorelease];
        [responseObj setupFromDictionary:bodyObj error:nil];
        
        return responseObj;
    }
    else
    {
        // Is this an error object, or just an explosion?
        CIAPILogAbout(CIAPILogLevelWarn, CIAPICoreClientModule, self, @"Synchronous request %X FAILED. Was to URL %@, Response = %@ ",
                      request, [urlResponse URL], [[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding] autorelease]);
    }
    
    return nil;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate error:(NSError**)error
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asynchronous request %@ started, calling back to delegate %X", request, delegate);
    CIAPIRequestToken *requestToken = [[[CIAPIRequestToken alloc] initWithRequest:request delegate:delegate] autorelease];
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, requestToken, @"Request %@ created request token %X", request, requestToken);
    
    // See if we have a cached reply already setup
    if ([requestCache hasCachedResponseForRequest:request])
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asyncronous request fulfilled by cache!");
        // We'll going to return this request token, preconfigured
        requestToken.responseObject = [requestCache cachedResponseForRequest:request];
        
        dispatch_async(dispatchQueue, ^{
            [self _dispatchCacheCallback:requestToken];
        });
        
        return requestToken;
    }
    
    NSURLRequest *urlRequest = [self _buildURLRequestFromCIAPIRequest:request error:error];
    
    // TODO: Set error
    if (!urlRequest)
        return nil;
    
    [requestToken setURLRequest:urlRequest];
    
    [requestDispatcher scheduleRequestToken:requestToken];
    
    return requestToken;
}

- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request successBlock:(CIAPIRequestSuccessCallback)callbackSuccessBlock
                     failureBlock:(CIAPIRequestFailureCallback)callbackFailureBlock error:(NSError**)error;
{    
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asynchronous request %@ started, calling back to success block %X and failure block %X", request, callbackSuccessBlock, callbackFailureBlock);
    CIAPIRequestToken *requestToken = [[[CIAPIRequestToken alloc] initWithRequest:request successBlock:callbackSuccessBlock failureBlock:callbackFailureBlock] autorelease];
    CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, requestToken, @"Request %@ created request token %X", request, requestToken);
 
    // See if we have a cached reply already setup
    if ([requestCache hasCachedResponseForRequest:request])
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPICoreClientModule, self, @"Asyncronous request fulfilled by cache!");
        
        // We're going return this request token, preconfigured
        requestToken.responseObject = [requestCache cachedResponseForRequest:request];
    
        dispatch_async(dispatchQueue, ^{
            [self _dispatchCacheCallback:requestToken];
        });
        
        return requestToken;        
    }
    
    NSURLRequest *urlRequest = [self _buildURLRequestFromCIAPIRequest:request error:error];
    
    // TODO: Set error
    if (!urlRequest)
        return nil;
    
    [requestToken setURLRequest:urlRequest];
    
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

- (void)setDispatchQueue:(dispatch_queue_t)newQueue
{
    // Eventually, release the old dispatch queue (we do it on the queue in case we're the last holder, and it's running)
    if (dispatchQueue)
        dispatch_async(dispatchQueue, ^{ dispatch_release(dispatchQueue); } );
    
    dispatch_retain(newQueue);
    dispatchQueue = newQueue;
    requestDispatcher.dispatchQueue = newQueue;
}

/*
 * Private members
 */

- (NSURLRequest*)_buildURLRequestFromCIAPIRequest:(CIAPIObjectRequest*)ciapiRequest error:(NSError**)error
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[ciapiRequest propertiesForRequest]];
    // This call will mutable the parameters to consume the ones used in the URL. This covers POST requests that have URL parameters
    NSString *urlStr = [self _buildURLFromTemplate:[ciapiRequest urlTemplate] parameters:parameters error:error];
    
    NSURL *url = [NSURL URLWithString:urlStr relativeToURL:CIAPI_BASE_URL];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                          timeoutInterval:CIAPI_REQUEST_TIMEOUT_LENGTH];
    
    if ([ciapiRequest requestType] == CIAPIRequestGET)
    {
        [urlRequest setHTTPMethod:@"GET"];
    }
    else if ([ciapiRequest requestType] == CIAPIRequestPOST)
    {
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[parameters JSONData]];
        [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    else
    {
        assert(FALSE);
    }
    
    [urlRequest addValue:username forHTTPHeaderField:@"UserName"];
    [urlRequest addValue:sessionID forHTTPHeaderField:@"Session"];
    
    return urlRequest;
}

// TODO: We don't really know which URL parameters are optional, so we require them all
- (NSString*)_buildURLFromTemplate:(NSString*)urlTemplate parameters:(NSMutableDictionary*)parameters error:(NSError**)error
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
            
            if (![scanner scanString:@"}" intoString:nil])
            {
                if (error)
                    *error = [NSError errorWithDomain:@"TODO" code:0 userInfo:nil];
                return nil;
            }
        }
    }
    
    return builtURL;
}
         
- (void)_dispatchCacheCallback:(CIAPIRequestToken*)token
{
    // We retained it this far, but it's time to let it go
    [token autorelease];
    
    if (token.callbackDelegate && [token.callbackDelegate respondsToSelector:@selector(requestSucceeded:result:)])
        [token.callbackDelegate requestSucceeded:token result:token.responseObject];
    else if (token.callbackSuccessBlock)
        token.callbackSuccessBlock(token, token.responseObject);
}

- (void)willReportSuccessfulRequest:(CIAPIRequestToken *)token
{
    // We can cache this!
    [requestCache cacheResponse:token.responseObject forRequest:token.requestObject];
}

- (void)willReportFailedRequest:(CIAPIRequestToken *)token
{
}

@end
