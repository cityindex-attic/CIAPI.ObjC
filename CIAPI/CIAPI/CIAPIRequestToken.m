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

@synthesize callbackBlock;
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
        callbackBlock = nil;
        attemptCount = 0;
    }
    
    return self;
}

- (CIAPIRequestToken*)initWithRequest:(CIAPIObjectRequest*)objRequest block:(CIAPIRequestCallback)block
{
    NSAssert(objRequest != nil, @"Cannot create a request token for a nil request");
    NSAssert(block != nil, @"Cannot create a request token for a nil callback block");
    
    self = [super init];
    
    if (self)
    {
        requestObject = [objRequest retain];
        callbackBlock = [block retain];
        callbackDelegate = nil;
        attemptCount = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [requestObject release];
    [callbackDelegate release];
    [callbackBlock release];
    
    [super dealloc];
}

- (void)setRKRequest:(id)rkRequest
{
    NSAssert(rkRequest != nil, @"Cannot set a nil rkRequest");
    underlyingRequest = rkRequest;
}

@end
