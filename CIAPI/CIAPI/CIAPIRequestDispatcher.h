//
//  RequestDispatcher.h
//  CIAPI
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ThrottledQueueMultiplexer.h"

#import "CIAPIURLConnection.h"
#import "CIAPIRequestToken.h"

enum RequestFailureType
{
    RequestTimedOut,
    RequestEndPointNotFound,
    RequestRemoteError,
    RequestInternalError,
    RequestUnknownError
};

@interface CIAPIRequestDispatcher : NSObject<CIAPIURLConnectionDelegate> {
@private
    NSUInteger maximumRequestAttempts;
    NSUInteger throttleSize;
    NSTimeInterval throttlePeriod;
    
    BOOL dispatcherShouldRun;
        
    NSMutableDictionary *namedQueueMap;
    ThrottledQueueMultiplexer *queueMultiplexer;    

    NSMutableDictionary *connectionToTokenMapper;
}

@property (readonly) NSUInteger maximumRequestAttempts;
@property (readonly) NSUInteger throttleSize;
@property (readonly) NSTimeInterval throttlePeriod;

- (CIAPIRequestDispatcher*)initWithMaximumRetryAttempts:(NSUInteger)_maximumRequestAttempts throttleSize:(NSUInteger)_throttleSize
                                    throttlePeriod:(NSTimeInterval)_throttlePeriod;

- (void)scheduleRequestToken:(CIAPIRequestToken*)token;
- (BOOL)unscheduleRequestToken:(CIAPIRequestToken*)token;

- (void)startDispatcher;
- (void)stopDispatcher;

- (void)dispatchThread:(id)ignore;

@end

@interface CIAPIRequestDispatcher ()

- (void)dispatchSuccessfulRequest:(CIAPIRequestToken*)token result:(id)result;
- (void)rescheduleFailedRequest:(CIAPIRequestToken*)token forLastError:(enum RequestFailureType)error;

- (void)mainThreadSuccessDispatcher:(CIAPIRequestToken*)token;
- (void)mainThreadFailureDispatcher:(CIAPIRequestToken*)token;

@end
