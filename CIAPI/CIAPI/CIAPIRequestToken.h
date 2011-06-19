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
    CIAPIRequestCallback callbackBlock;
    id<CIAPIRequestDelegate> callbackDelegate;
    CIAPIObjectRequest *requestObject;
    
    RKRequest *underlyingRequest;
    int attemptCount;
}

@property (readonly) CIAPIObjectRequest *requestObject;
@property int attemptCount;

// TODO: It bothers me that the RKRequest object is public in a user facing interface
@property (readonly) RKRequest *underlyingRequest;

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate;
- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest block:(CIAPIRequestCallback)block;

@end
