//
//  RequestDispatcher.h
//  CIAPI
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestKit/RestKit.h"

#import "ThrottledQueueMultiplexer.h"
#import "CIAPIRequestToken.h"

enum RequestFailureType
{
    RequestTimedOut,
    RequestEndPointNotFound,
    RequestRemoteError,
    RequestInternalError,
    RequestUnknownError
};

@interface RequestDispatcher : NSObject<RKRequestDelegate> {
@private
    int maximumRequestAttempts;
    BOOL dispatcherShouldRun;
        
    NSMutableDictionary *namedQueueMap;
    ThrottledQueueMultiplexer *queueMultiplexer;    
    
    RKClient *underlyingClient;
    NSMutableDictionary *rkRequestToTokenMapper;
}

@property (readonly) int maximumRequestAttempts;

- (void)scheduleRequestToken:(CIAPIRequestToken*)token;
- (BOOL)unscheduleRequestToken:(CIAPIRequestToken*)token;

- (void)startDispatcher;
- (void)stopDispatcher;

- (void)dispatchThread:(id)ignore;

@end

@interface RequestDispatcher ()

- (void)rescheduleRequest:(CIAPIRequestToken*)token forLastError:(int)error;

@end
