//
//  CIAPIDataDelegate.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CIAPIRequestDelegate <NSObject>
@optional

- (void)requestSucceeded:(id)request result:(id)result;
- (void)requestFailed:(id)request error:(NSError**)error;

@end
