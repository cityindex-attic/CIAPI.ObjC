//
//  CIAPIAuthenticatorDelegate.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIAuthenticator.h"

@class CIAPIAuthenticator;
@class CIAPIClient;

@protocol CIAPIAuthenticatorDelegate <NSObject>

@optional

- (void)authenticationSucceeded:(CIAPIAuthenticator*)authenticator client:(CIAPIClient*)client;
- (void)authenticationFailed:(CIAPIAuthenticator*)authenticator error:(NSError*)error;

@end
