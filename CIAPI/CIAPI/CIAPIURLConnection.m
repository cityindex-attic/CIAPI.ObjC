//
//  CIAPIURLConnection.m
//  CIAPI
//
//  Created by Adam Wright on 30/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIURLConnection.h"

#import "CIAPILogging.h"

@implementation CIAPIURLConnection

+ (NSData*)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse**)response error:(NSError**)error
{
    NSAssert(response != nil, @"Cannot make a syncronous request with a nil response target!");
    CIAPILogFromModule(CIAPILogLevelNote, CIAPIHTTPModule, @"Beginning synchronous HTTP request to %@", [request URL]);
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
}

+ (CIAPIURLConnection*)CIAPIURLConnectionForRequest:(NSURLRequest*)request delegate:(id<CIAPIURLConnectionDelegate>)_delegate
{
    CIAPIURLConnection *connection = [[[CIAPIURLConnection alloc] initWithRequest:request] autorelease];
    connection.delegate = _delegate;
    
    return connection;
}

@synthesize delegate;

- (CIAPIURLConnection*)initWithRequest:(NSURLRequest*)_request
{
    NSAssert(_request != nil, @"Cannot create a URL connection with a nil request");
    self = [super init];
    
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Building a CIAPIURLConnection request to %@", [_request URL]);
    
    if (self)
    {        
        request = [_request retain];
        
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return self;
}

- (void)dealloc
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Destroying a CIAPIURLConnection request");
    
    [response release];
    [allData release];
    [connection release];
    [request release];
    
    [super dealloc];
}

- (void)start
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Sending HTTP request to %@", [request URL]);
    [connection start];
}

- (void)cancel
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Cancelling HTTP request to %@", [request URL]);
    
    [connection cancel];
}

// Delegate methods for NSURLRequest
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"CIAPIURLConnection finished OK");
    
    if ([delegate respondsToSelector:@selector(requestSucceeded:request:response:data:)])
        [delegate requestSucceeded:self request:request response:(NSHTTPURLResponse*)response data:allData] ;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    CIAPILogAbout(CIAPILogLevelWarn, CIAPIHTTPModule, self, @"CIAPIURLConnection failed with error %@", error);
    
    // TODO: Cut down error space to just CIAPI errors for people
    if ([delegate respondsToSelector:@selector(requestFailed:request:response:error:)])
        [delegate requestFailed:self request:request response:(NSHTTPURLResponse*)response error:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Data chunk of length %u received", [data length]);
    
    [allData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)_response
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Got initial response from request");
    
    response = [_response retain];
    allData = [[NSMutableData alloc] init];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    CIAPILogAbout(CIAPILogLevelError, CIAPIHTTPModule, self, @"Was asked to authenticate, but I declined. Sorry!");
    
    return NO;
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    CIAPILogAbout(CIAPILogLevelWarn, CIAPIHTTPModule, self, @"Cancelled authentication challenge");
    // We don't care, at the moment
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    CIAPILogAbout(CIAPILogLevelWarn, CIAPIHTTPModule, self, @"Received an authentication challenge!");
    // We don't care, at the moment
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    // We don't care, at the moment
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Declining to cache HTTP response");
    return nil;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)_request redirectResponse:(NSURLResponse *)redirectResponse
{
    CIAPILogAbout(CIAPILogLevelNote, CIAPIHTTPModule, self, @"Accepting redirect to HTTP request to %@", [_request URL]);
    return _request;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}

@end
