//
//  CIAPIRequestToken.h
//  CIAPI
//
//  Created by Adam Wright on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIAPIObjectRequest.h"

/*
 * A CIAPIRequestToken represents a single object that is currently active; i.e. in transit between ourselves and the server
 * or from the server and ourselves. It tracks retries and errors.
 */
@interface CIAPIRequestToken : NSObject {    
    id underlyingRequest;
    int attemptCount;

    CIAPIRequestCallback callbackBlock;
    id<CIAPIRequestDelegate> callbackDelegate;
    CIAPIObjectRequest *requestObject;
    
    NSError *responseError;
    id responseObject;
}

// TODO: It bothers me that the RKRequest object is public in a user facing interface
@property (readonly) id underlyingRequest;
@property int attemptCount;

@property (readonly) CIAPIRequestCallback callbackBlock;
@property (readonly) id<CIAPIRequestDelegate> callbackDelegate;
@property (readonly) CIAPIObjectRequest *requestObject;

@property (assign) NSError *responseError;
@property (assign) id responseObject;

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate;
- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest block:(CIAPIRequestCallback)block;

- (void)setRKRequest:(id)rkRequest;

@end
