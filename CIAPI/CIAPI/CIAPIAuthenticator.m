//
//  CIAPIAuthenticator.m
//  CIAPI
//
//  Created by Adam Wright on 08/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIAuthenticator.h"
#import "CIAPIConfigConstants.h"

#import "CIAPICreateSessionResponse.h"
#import "CIAPILogOnRequest.h"


@implementation CIAPIAuthenticator

- (id)init
{
    self = [super init];
    
    if (self)
    {
        rkManager = [[RKObjectManager objectManagerWithBaseURL:CIAPI_BASE_URI] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [rkManager dealloc];
    
    [super dealloc];
}

- (CIAPIClient*)authenticateWithUserName:(NSString*)userName password:(NSString*)password error:(NSError**)error
{
    CIAPILogOnRequest *loRequest = [[CIAPILogOnRequest alloc] init];
    loRequest.UserName = userName;
    loRequest.Password = password;
    
    RKObjectLoader *loader = [rkManager objectLoaderWithResourcePath:@"session" delegate:self];

    loader.params = [RKJSONSerialization JSONSerializationWithObject:[loRequest propertiesForSerialization]];
    loader.method = RKRequestMethodPOST;
    loader.objectClass = [CIAPICreateSessionResponse class];
    
    [loader sendSynchronously];
    
    return nil;
}

- (CIAPIRequest*)authenticateWithUserName:(NSString*)userName password:(NSString*)password delegate:(id<CIAPIAuthenticatorDelegate>)delegate
{
    return nil;
}

- (CIAPIRequest*)authenticateWithUserName:(NSString*)userName password:(NSString*)password block:(CIAPIAuthenticatorCallback)callback
{
    return nil;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    NSLog(@"Succeeded with %@", objects);    
}

/**
 * Sent when an object loaded failed to load the collection due to an error
 */
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"Failed with %@", error);
}

@end
