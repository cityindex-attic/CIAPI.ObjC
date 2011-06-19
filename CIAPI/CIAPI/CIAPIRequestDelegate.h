//
//  CIAPIDataDelegate.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CIAPIRequestToken;

@protocol CIAPIRequestDelegate <NSObject>
@optional

- (void)requestSucceeded:(CIAPIRequestToken *)requestToken result:(id)result;
- (void)requestFailed:(CIAPIRequestToken *)requestToken error:(NSError*)error;

@end
