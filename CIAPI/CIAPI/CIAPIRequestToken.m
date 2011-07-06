//
//  CIAPIRequestToken.m
//  CIAPI
//
//  Created by Adam Wright on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIRequestToken.h"


@implementation CIAPIRequestToken

@synthesize underlyingRequest;
@synthesize attemptCount;

@synthesize callbackSuccessBlock;
@synthesize callbackFailureBlock;
@synthesize callbackDelegate;
@synthesize requestObject;

@synthesize responseError;
@synthesize responseObject;

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest delegate:(id<CIAPIRequestDelegate>)delegate
{
    NSAssert(objRequest != nil, @"Cannot create a request token for a nil request");
    NSAssert(delegate != nil, @"Cannot create a request token for a nil delegate");
    
    self = [super init];
    
    if (self)
    {
        requestObject = [objRequest retain];
        callbackDelegate = delegate;
        attemptCount = 0;
    }
    
    return self;
}

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest successBlock:(CIAPIRequestSuccessCallback)successBlock
                         failureBlock:(CIAPIRequestFailureCallback)failureBlock
{
    NSAssert(objRequest != nil, @"Cannot create a request token for a nil request");
    
    self = [super init];
    
    if (self)
    {
        requestObject = [objRequest retain];
        if (successBlock)
            callbackSuccessBlock = Block_copy(successBlock);
        if (failureBlock)
            callbackFailureBlock = Block_copy(failureBlock);
        callbackDelegate = nil;
        attemptCount = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [requestObject release];
    [callbackDelegate release];

    if (callbackSuccessBlock)
        Block_release(callbackSuccessBlock);
    if (callbackFailureBlock)
        Block_release(callbackFailureBlock);
    
    [underlyingRequest release];
    
    [responseError release];
    [responseObject release];
    
    [super dealloc];
}

- (void)setURLRequest:(id)urlRequest
{
    NSAssert(urlRequest != nil, @"Cannot set a nil urlRequest");
    underlyingRequest = [urlRequest retain];
}

@end
