//
//  CIClient.h
//  CIAPI
//
//  Created by Adam Wright on 29/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"
#import "CIAPIRequestToken.h"
#import "CIAPIRequestDelegate.h"
#import "CIAPIStreamDelegate.h"
#import "CIAPIRequestDispatcher.h"
#import "CIAPIRequestCache.h"

enum CIAPIRequestCancellationResult
{
    RequestCancelledOK,
    RequestCancellationFailedUnknown,
    RequestCancellationFailedInflight
};

typedef void(^CIAPIStreamCallback)(NSString *endPoint, NSString *channel, id message, NSError *error);

@interface CIAPIClient : NSObject<CIAPIRequestDispatcherDelegate> {
    NSString *username;
    NSString *sessionID;
    
    CIAPIRequestDispatcher *requestDispatcher;
    CIAPIRequestCache *requestCache;
}

@property (readonly) NSString *username;
@property (readonly) NSString *sessionID;

- (CIAPIClient*)initWithUsername:(NSString*)_username sessionID:(NSString*)_sessionID;

- (id)makeRequest:(CIAPIObjectRequest*)request error:(NSError**)error;
- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate error:(NSError**)error;
- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request block:(CIAPIRequestCallback)callbackBlock error:(NSError**)error;

- (enum CIAPIRequestCancellationResult)cancelRequest:(CIAPIRequestToken*)token;

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate;
- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block;

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel;
- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate;
- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block;

@end

// Private interface members
@interface CIAPIClient ()

- (NSURLRequest*)_buildURLRequestFromCIAPIRequest:(CIAPIObjectRequest*)ciapiRequest error:(NSError**)error;
- (NSString*)_buildURLFromTemplate:(NSString*)urlTemplate parameters:(NSMutableDictionary*)parameters error:(NSError**)error;
- (void)_dispatchCacheCallback:(CIAPIRequestToken*)token;

@end