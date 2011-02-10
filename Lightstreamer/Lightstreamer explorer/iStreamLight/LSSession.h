//
//  LSSession.h
//  iStreamLight v. 1.0.6
//
//  Created by Gianluca Bertani on 02/07/08.
//  Copyright 2008-2010 Flying Dolphin Studio. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without 
//  modification, are permitted provided that the following conditions 
//  are met:
//
//  * Redistributions of source code must retain the above copyright notice, 
//    this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, 
//    this list of conditions and the following disclaimer in the documentation 
//    and/or other materials provided with the distribution.
//  * Neither the name of Gianluca Bertani nor the names of its contributors 
//    may be used to endorse or promote products derived from this software 
//    without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.
//

/*!
 @header	LSSession
 @abstract	Lightstreamer session class and methods
 */

#import "LSMode.h"

#define UNFILTERED (-1.0)


@class LSClient;
@protocol LSListener;
@class LSSessionOptions;
@class LSException;

/*!
 @class
 @abstract		A streaming session
 @discussion	This class represents a streaming session from a
				specific Lightstreamer client. It exposes all the
				methods to add and remove items from the subscription.
 */
@interface LSSession : NSObject {
	
@private
	NSString *_sessionId;
	LSClient *_client;

	NSString *_host;
	NSInteger _port;
	BOOL _secure;
	NSString *_user;
	NSString *_password;
	NSString *_adapterSet;
	LSSessionOptions *_options;
	BOOL _autorebind;

	id<LSListener> _listener;
	
	NSString *_command;
	BOOL _connected;
	NSInputStream *_stream;
	NSOutputStream *_outStream;
	
	NSMutableString *_buffer;
	NSCondition *_connecting;
	LSException *_connectionException;
	BOOL _loopReceived;
	
	NSURL *_controlLink;
}

@property(readonly, copy) NSString *sessionId;
@property(readonly) LSClient *client;

@property(readonly, copy) NSString *user;
@property(readonly, copy) NSString *adapterSet;
@property(readonly, copy) LSSessionOptions *options;
@property(readonly) BOOL autorebind;

@property(readonly) id<LSListener> listener;

@property(readonly) BOOL isConnected;
@property(readonly) NSURL *controlLink;

- (void) add:(NSInteger)window adapter:(NSString *)adapter table:(NSInteger)table group:(NSString *)group schema:(NSString *)schema selector:(NSString *)selector mode:(LSMode)mode requestedBufferSize:(NSInteger)requestedBufferSize requestedMaxFrequency:(double)requestedMaxFrequency snapshot:(BOOL)snapshot;

- (void) addSilent:(NSInteger)window adapter:(NSString *)adapter table:(NSInteger)table group:(NSString *)group schema:(NSString *)schema selector:(NSString *)selector mode:(LSMode)mode requestedBufferSize:(NSInteger)requestedBufferSize requestedMaxFrequency:(double)requestedMaxFrequency snapshot:(BOOL)snapshot;
- (void) start:(NSInteger)window;

- (void) delete:(NSInteger)window;

- (void) constrain:(double)requestedMaxBandwidth topMaxFrequency:(double)topMaxFrequency;

- (void) sendMessage:(NSString *)message;

- (void) destroy;

@end
