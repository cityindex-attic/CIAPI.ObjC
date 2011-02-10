//
//  LSSession.m
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

#import <Foundation/Foundation.h>
#import "LSSession.h"
#import "LSSession+Internals.h"
#import "LSClient.h"
#import "LSListener.h"
#import "LSSessionOptions.h"
#import "LSException.h"


@implementation LSSession

@synthesize sessionId= _sessionId;
@synthesize client= _client;

@synthesize user= _user;
@synthesize adapterSet= _adapterSet;
@synthesize options= _options;
@synthesize autorebind= _autorebind;

@synthesize listener= _listener;

@synthesize isConnected= _connected;
@dynamic controlLink;

- (NSURL *)controlLink {
	if (_controlLink)
		return _controlLink;
	else
		return _client.serverURL;
}

- (void) add:(NSInteger)window adapter:(NSString *)adapter table:(NSInteger)table group:(NSString *)group schema:(NSString *)schema selector:(NSString *)selector mode:(LSMode)mode requestedBufferSize:(NSInteger)requestedBufferSize requestedMaxFrequency:(double)requestedMaxFrequency snapshot:(BOOL)snapshot {
	NSString *path= @"lightstreamer/control.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_window=%d", window];
	query= [query stringByAppendingString:@"&LS_op=add"];
	query= [query stringByAppendingFormat:@"&LS_id%d=%@", table, [group stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_schema%d=%@", table, [schema stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	if (adapter)
		query= [query stringByAppendingFormat:@"&LS_data_adapter%d=%@", table, [adapter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	if (selector)
		query= [query stringByAppendingFormat:@"&LS_selector%d=%@", table, [selector stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	switch (mode) {
		case LSModeRaw: query= [query stringByAppendingFormat:@"&LS_mode%d=RAW", table]; break;
		case LSModeMerge: query= [query stringByAppendingFormat:@"&LS_mode%d=MERGE", table]; break;
		case LSModeDistinct: query= [query stringByAppendingFormat:@"&LS_mode%d=DISTINCT", table]; break;
		case LSModeCommand: query= [query stringByAppendingFormat:@"&LS_mode%d=COMMAND", table]; break;
	}
	
	if (requestedBufferSize > 0)
		query= [query stringByAppendingFormat:@"&LS_requested_buffer_size%d=%d", table, requestedBufferSize];
	
	if (requestedMaxFrequency > 0.0)
		query= [query stringByAppendingFormat:@"&LS_requested_max_frequency%d=%.2lf", table, requestedMaxFrequency];
	else if (requestedMaxFrequency == UNFILTERED)
		query= [query stringByAppendingFormat:@"&LS_requested_max_frequency%d=unfiltered", table];
	
	query= [query stringByAppendingFormat:@"&LS_snapshot%d=%s", table, (snapshot ? "true" : "false")];
	
	[self control:path query:query];
}

- (void) addSilent:(NSInteger)window adapter:(NSString *)adapter table:(NSInteger)table group:(NSString *)group schema:(NSString *)schema selector:(NSString *)selector mode:(LSMode)mode requestedBufferSize:(NSInteger)requestedBufferSize requestedMaxFrequency:(double)requestedMaxFrequency snapshot:(BOOL)snapshot {
	NSString *path= @"lightstreamer/control.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_window=%d", window];
	query= [query stringByAppendingString:@"&LS_op=add_silent"];
	query= [query stringByAppendingFormat:@"&LS_id%d=%@", table, [group stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_schema%d=%@", table, [schema stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	if (adapter)
		query= [query stringByAppendingFormat:@"&LS_data_adapter=%@", [adapter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

	if (selector)
		query= [query stringByAppendingFormat:@"&LS_selector%d=%@", table, [selector stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	switch (mode) {
		case LSModeRaw: query= [query stringByAppendingFormat:@"&LS_mode%d=RAW", table]; break;
		case LSModeMerge: query= [query stringByAppendingFormat:@"&LS_mode%d=MERGE", table]; break;
		case LSModeDistinct: query= [query stringByAppendingFormat:@"&LS_mode%d=DISTINCT", table]; break;
		case LSModeCommand: query= [query stringByAppendingFormat:@"&LS_mode%d=COMMAND", table]; break;
	}
	
	if (requestedBufferSize > 0)
		query= [query stringByAppendingFormat:@"&LS_requested_buffer_size%d=%d", table, requestedBufferSize];
	
	if (requestedMaxFrequency > 0.0)
		query= [query stringByAppendingFormat:@"&LS_requested_max_frequency%d=%.2lf", table, requestedMaxFrequency];
	else if (requestedMaxFrequency == UNFILTERED)
		query= [query stringByAppendingFormat:@"&LS_requested_max_frequency%d=unfiltered", table];
	
	query= [query stringByAppendingFormat:@"&LS_snapshot%d=%s", table, (snapshot ? "true" : "false")];
	
	[self control:path query:query];
}

- (void) start:(NSInteger)window {
	NSString *path= @"lightstreamer/control.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_window=%d", window];
	query= [query stringByAppendingString:@"&LS_op=start"];

	[self control:path query:query];
}

- (void) delete:(NSInteger)window {
	NSString *path= @"lightstreamer/control.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_window=%d", window];
	query= [query stringByAppendingString:@"&LS_op=delete"];
	
	[self control:path query:query];
}

- (void) constrain:(double)requestedMaxBandwidth topMaxFrequency:(double)topMaxFrequency {
	NSString *path= @"lightstreamer/control.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingString:@"&LS_op=constrain"];
	
	if (requestedMaxBandwidth > 0.0)
		query= [query stringByAppendingFormat:@"&LS_requested_max_bandwidth=%.2lf", requestedMaxBandwidth];
	
	if (topMaxFrequency > 0.0)
		query= [query stringByAppendingFormat:@"&LS_top_max_frequency=%.2lf", topMaxFrequency];
	
	[self control:path query:query];
}

- (void) sendMessage:(NSString *)message {
	NSString *path= @"lightstreamer/send_message.txt";
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [query stringByAppendingFormat:@"&LS_message=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	[self control:path query:query];
}

- (void) destroy {
	@try {
		NSString *path= @"lightstreamer/control.txt";
		
		NSString *query= @"";
		query= [query stringByAppendingFormat:@"LS_session=%@", [_sessionId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		query= [query stringByAppendingString:@"&LS_op=destroy"];
		
		[self control:path query:query];

	} @catch (id e) {
	
		// Whatever the server says, we close the stream
		[self disconnect];
		
		@throw e;
	}
}


@end
