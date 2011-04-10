//
//  CIAPIAuthenticator.h
//  CIAPI
//
//  Created by Adam Wright on 08/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestKit/RestKit.h"

#import "CIAPIAuthenticatorDelegate.h"
#import "CIAPIClient.h"
#import "CIAPIRequest.h"

typedef void(^CIAPIAuthenticatorCallback)(CIAPIClient *client, NSError *error);

@interface CIAPIAuthenticator : NSObject<RKObjectLoaderDelegate> {
    CIAPIClient *client;
    
    @private
    RKObjectManager *rkManager;
}

- (CIAPIClient*)authenticateWithUserName:(NSString*)userName password:(NSString*)password error:(NSError**)error;
- (CIAPIRequest*)authenticateWithUserName:(NSString*)userName password:(NSString*)password delegate:(id<CIAPIAuthenticatorDelegate>)delegate;
- (CIAPIRequest*)authenticateWithUserName:(NSString*)userName password:(NSString*)password block:(CIAPIAuthenticatorCallback)callback;

@end