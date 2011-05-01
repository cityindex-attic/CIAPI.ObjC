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

@class CIAPIAuthenticator;

typedef void(^CIAPIAuthenticatorCallback)(CIAPIAuthenticator *authenticator, NSError *error);

@interface CIAPIAuthenticator : NSObject<RKRequestDelegate> {
    CIAPIClient *client;
    
    @private
    RKClient *rkClient;
    RKRequest *request;
}

/** Returns the current authenticated client provided by this authenticator */
@property (readonly) CIAPIClient *client;

/** Gets or sets the delegate that will be informed of responses to asynchronous authentication. The delegate object is *not* retained. */
@property (assign) id<CIAPIAuthenticatorDelegate> delegate;

/** Gets or sets the block that will be invoked for responses to asynchronous authentication */
@property (copy) CIAPIAuthenticatorCallback block;

/** Synchronously attempts to authenticate with the CIAPI servers using the given credientials.
 
 @param userName The account username to authenticate as
 @param password The account password
 @return TRUE on successful authentication, FALSE otherwise (with error set)
 */
- (BOOL)authenticateWithUserNameSynchronously:(NSString*)userName password:(NSString*)password error:(NSError**)error;

/** Attempts to authenticate with the CIAPI servers using the given credientials. Responses will be given to the delegate and/or blocks set on the authenticator object.
 
    Repeated calls to this function will reset the authentication attempts. To authenticate with several accounts, use multiple instances of CIAPIAuthenticator.
 
 @param userName The account username to authenticate as
 @param password The account password
 */
- (void)authenticateWithUserName:(NSString*)userName password:(NSString*)password;

@end

@interface CIAPIAuthenticator ()

- (RKRequest*)_buildRequestWithUsername:(NSString*)userName password:(NSString*)password;
- (BOOL)_setupClientOrError:(RKResponse*)response error:(NSError**)error;

@end