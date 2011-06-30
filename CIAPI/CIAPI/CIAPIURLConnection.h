//
//  CIAPIURLConnection.h
//  CIAPI
//
//  Created by Adam Wright on 30/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CIAPIURLConnection;

@protocol CIAPIURLConnectionDelegate <NSObject>
@optional

- (void)requestSucceeded:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response data:(NSData*)data;
- (void)requestFailed:(CIAPIURLConnection*)connection request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response error:(NSError*)error;

@end

@interface CIAPIURLConnection : NSObject
{
    NSURLConnection *connection;
    NSURLRequest *request;
    NSMutableData *allData;
    NSURLResponse *response;
    
    id<CIAPIURLConnectionDelegate> delegate;
}

@property (assign) id<CIAPIURLConnectionDelegate> delegate;

+ (NSData*)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse**)response error:(NSError**)error;
+ (CIAPIURLConnection*)CIAPIURLConnectionForRequest:(NSURLRequest*)request delegate:(id<CIAPIURLConnectionDelegate>)_delegate;

- (CIAPIURLConnection*)initWithRequest:(NSURLRequest*)_request;
- (void)start;
- (void)cancel;


@end
