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
    NSURLRequest *underlyingRequest;
    int attemptCount;

    CIAPIRequestSuccessCallback callbackSuccessBlock;
    CIAPIRequestFailureCallback callbackFailureBlock;
    id<CIAPIRequestDelegate> callbackDelegate;
    CIAPIObjectRequest *requestObject;
    
    NSError *responseError;
    id responseObject;
}

@property (readonly) id underlyingRequest;
@property int attemptCount;

@property (readonly) CIAPIRequestSuccessCallback callbackSuccessBlock;
@property (readonly) CIAPIRequestFailureCallback callbackFailureBlock;
@property (readonly) id<CIAPIRequestDelegate> callbackDelegate;
@property (readonly) CIAPIObjectRequest *requestObject;

@property (retain) NSError *responseError;
@property (retain) id responseObject;

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate;
- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest successBlock:(CIAPIRequestSuccessCallback)successBlock
                         failureBlock:(CIAPIRequestFailureCallback)failureBlock;

- (void)setURLRequest:(NSURLRequest*)urlRequest;

@end
