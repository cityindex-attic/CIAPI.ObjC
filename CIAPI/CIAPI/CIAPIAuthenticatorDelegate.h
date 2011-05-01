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

@protocol CIAPIAuthenticatorDelegate <NSObject>

@optional

- (void)authenticationSucceeded:(CIAPIAuthenticator*)authenticator;
- (void)authenticationFailed:(CIAPIAuthenticator*)authenticator error:(NSError*)error;

@end
