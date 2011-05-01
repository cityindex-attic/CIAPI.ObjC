//
//  CIAPIRequestToken.h
//  CIAPI
//
//  Created by Adam Wright on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIAPIObjectRequest.h"

@interface CIAPIRequestToken : NSObject {
    CIAPIRequestCallback callbackBlock;
    id<CIAPIRequestDelegate> callbackDelegate;
    CIAPIObjectRequest *requestObject;
    
    RKRequest *underlyingRequest;
    int attemptCount;
}

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate;
- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest block:(CIAPIRequestCallback)block;

@end
