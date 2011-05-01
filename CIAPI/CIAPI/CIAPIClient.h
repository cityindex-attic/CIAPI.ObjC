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

#import "RestKit/RestKit.h"

enum CIAPIRequestCancellationResult
{
    RequestCancelledOK,
    RequestCancellationFailedUnknown,
    RequestCancellationFailedInflight
};

typedef void(^CIAPIStreamCallback)(NSString *endPoint, NSString *channel, id message, NSError *error);

@interface CIAPIClient : NSObject {
    NSString *username;
    NSString *sessionID;
    
    RKClient *underlyingClient;
    NSMutableDictionary *tokenToRequestMappings;
}

@property (readonly) NSString *username;
@property (readonly) NSString *sessionID;

- (CIAPIClient*)initWithUsername:(NSString*)_username sessionID:(NSString*)_sessionID;

- (id)makeRequest:(CIAPIObjectRequest*)request error:(NSError**)error;
- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request delegate:(id<CIAPIRequestDelegate>)delegate;
- (CIAPIRequestToken*)makeRequest:(CIAPIObjectRequest*)request block:(CIAPIRequestCallback)delegate;

- (enum CIAPIRequestCancellationResult)cancelRequest:(CIAPIRequestToken*)token;

- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate;
- (BOOL)subscribeToStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block;

- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel;
- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel delegate:(id<CIAPIStreamDelegate>)delegate;
- (BOOL)unsubscribeFromStreamEndPoint:(NSString*)endPoint channel:(NSString*)channel block:(CIAPIStreamCallback)block;

@end
