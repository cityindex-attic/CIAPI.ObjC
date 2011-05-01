//
//  CIAPIRequestToken.m
//  CIAPI
//
//  Created by Adam Wright on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIRequestToken.h"


@implementation CIAPIRequestToken

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate
{
    self = [super init];
    
    if (self)
    {
        requestObject = [objRequest retain];
        callbackDelegate = delegate;
        attemptCount = 0;
    }
    
    return self;
}
- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest block:(CIAPIRequestCallback)block;
{
    self = [super init];
    
    if (self)
    {
        requestObject = [objRequest retain];
        callbackBlock = block;
        attemptCount = 0;
    }
    
    return self;
}

@end
