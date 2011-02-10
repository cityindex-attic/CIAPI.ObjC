//
//  LSSession+Internals.m
//  iStreamLight v. 1.0.6
//
//  Created by Gianluca Bertani on 08/07/08.
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
#import "LSSession+Internals.h"
#import "LSException.h"
#import "LSSessionOptions+Internals.h"
#import "LSListener.h"
#import "LSUnchangedValue.h"
#import "LSClient.h"


@implementation LSSession (Internals)

- (id) init {
	[super init];
	
	_sessionId= nil;
	_client= nil;
	
	_host= nil;
	_port= 0;
	_user= nil;
	_password= nil;
	_adapterSet= nil;
	_options= nil;
	_autorebind= NO;
	
	_listener= nil;
	
	_command= nil;
	_connected= NO;
	_stream= nil;
	_outStream= nil;

	_connecting= nil;
	_connectionException= nil;
	
	_buffer= [NSMutableString stringWithCapacity:1024];
	[_buffer retain];
	
	_controlLink= nil;
	
	return self;
}

- (void) dealloc {
	[_sessionId release];

	[_host release];
	[_user release];
	[_password release];
	[_adapterSet release];
	[_options release];
	
	[_client release];
	
	[_listener release];
	
	[_buffer release];
	
	[_controlLink release];

	[super dealloc];
}

- (void) create:(LSClient *)client host:(NSString *)host port:(NSInteger)port secure:(BOOL)secure user:(NSString *)user password:(NSString *)password adapterSet:(NSString *)adapterSet listener:(id<LSListener>)listener options:(LSSessionOptions *)options autorebind:(BOOL)autorebind {
	if (_connected)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't create session" reason:@"Session is connected"] autorelease];

	if (_client)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't create session" reason:@"Session creation has been invoked for second time"] autorelease];
	
	_client= [client retain];
	
	_host= [host copy];
	_port= port;
	_secure= secure;
	_user= [user copy];
	_password= [password copy];
	_adapterSet= [adapterSet copy];
	_options= [options copy];
	_autorebind= autorebind;
	
	_listener= [listener retain];
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_user=%@", ((_user == nil) ? @"" : [_user stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
	if (_password) 
		query= [query stringByAppendingFormat:@"&LS_password=%@", [_password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	if (_adapterSet) 
		query= [query stringByAppendingFormat:@"&LS_adapter=%@", [_adapterSet stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	query= [_options appendToQueryString:query];

	_command= @"POST /lightstreamer/create_session.txt  HTTP/1.0\r\n";
	_command= [_command stringByAppendingFormat:@"Host: %@\r\n", _host];
	_command= [_command stringByAppendingString:@"User-Agent: iStreamLight 1.0.6/iOS\r\n"];
	_command= [_command stringByAppendingString:@"Content-Type: application/x-www-form-urlencoded\r\n"];
	_command= [_command stringByAppendingFormat:@"Content-Length: %d\r\n\r\n", [query length]];
	_command= [_command stringByAppendingString:query];
	
	_connectionException= nil;
	_connecting= [[NSCondition alloc] init];
	
	[NSThread detachNewThreadSelector:@selector(connectAndReceive) toTarget:self withObject:nil];
	
	[_connecting lock];
	[_connecting wait];
	[_connecting unlock];
	
	[_connecting release];
	_connecting= nil;
	
	if (_connectionException)
		@throw [_connectionException autorelease];
}

- (void) bind:(NSString *)host port:(NSInteger)port secure:(BOOL)secure options:(LSSessionOptions *)options {
	if (_connected)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't bind session" reason:@"Session is connected"] autorelease];
	
	if (!_client)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't bind session" reason:@"Session creation has not been invoked yet"] autorelease];
	
	if (!_sessionId)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't bind session" reason:@"Session has no valid session ID"] autorelease];
	
	[_host autorelease];
	_host= [host copy];
	
	_port= port;

	_secure= secure;

	[_options autorelease];
	_options= [options retain];
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_session=%@", _sessionId];
	query= [_options appendToQueryString:query];
	
	_command= @"POST /lightstreamer/bind_session.txt  HTTP/1.0\r\n";
	_command= [_command stringByAppendingFormat:@"Host: %@\r\n", _host];
	_command= [_command stringByAppendingString:@"User-Agent: iStreamLight 1.0.6/iOS\r\n"];
	_command= [_command stringByAppendingString:@"Content-Type: application/x-www-form-urlencoded\r\n"];
	_command= [_command stringByAppendingFormat:@"Content-Length: %d\r\n\r\n", [query length]];
	_command= [_command stringByAppendingString:query];

	_connectionException= nil;
	_connecting= [[NSCondition alloc] init];

	[NSThread detachNewThreadSelector:@selector(connectAndReceive) toTarget:self withObject:nil];
	
	[_connecting lock];
	[_connecting wait];
	[_connecting unlock];
	
	[_connecting release];
	_connecting= nil;

	if (_connectionException)
		@throw [_connectionException autorelease];
}

- (void) connectAndReceive {
    NSAutoreleasePool *pool= [[NSAutoreleasePool alloc] init];
	
	NSInputStream *input= nil;
	NSOutputStream *output= nil;
	
	NSLog(@"Opening stream to %@:%d...", _host, _port);
	
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef) _host, _port, (CFReadStreamRef*) &input, (CFWriteStreamRef*) &output);
	
	[input setDelegate:self]; 
	[output setDelegate:self]; 
	
	if (_secure) {
		[input setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];
		[output setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];
	}
	
	NSRunLoop *loop= [NSRunLoop currentRunLoop];
	[input scheduleInRunLoop:loop forMode:NSDefaultRunLoopMode]; 
	[output scheduleInRunLoop:loop forMode:NSDefaultRunLoopMode]; 
	
	[input open]; 
	[output open];
	
	NSLog(@"Stream to %@:%d opened", _host, _port);

	_connected= YES;
	_loopReceived= NO;
	_stream= input;
	_outStream= output;
	
	do {
		[loop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
		
	} while (_connected);

	_stream= nil;
	_outStream= nil;
	
	NSLog(@"Closing stream to %@:%d...", _host, _port);

	[input close]; 
	[output close]; 
	
	[input removeFromRunLoop:loop forMode:NSDefaultRunLoopMode];
	[output removeFromRunLoop:loop forMode:NSDefaultRunLoopMode];
	
	[input release];
	[output release];
	
	NSLog(@"Stream to %@:%d closed", _host, _port);

	if (_autorebind && (!_connectionException) && _loopReceived) {
		@try {
			[_client bindSession:self options:_options];
			
		} @catch (LSException *lse) {
			[_listener onException:self exception:lse];
			
		} @catch (id e) {
			NSString *reason= [NSString stringWithFormat:@"Exception caught of class %@ and description '%@'", [[e class] description], [e description]];
			LSException *exception= [[LSException alloc] initWithClient:_client session:self description:@"Can't automatically rebind session" reason:reason];
			
			[_listener onException:self exception:[exception autorelease]];
		}
	}

	[pool drain];
}

- (void) disconnect {
	[self handleStreamClose];
}

- (void) stream:(NSStream *)stream handleEvent:(NSStreamEvent)streamEvent {
    NSAutoreleasePool *pool= [[NSAutoreleasePool alloc] init];

	@try {
		switch (streamEvent) { 
			case NSStreamEventHasBytesAvailable: {
				do {
					uint8_t buf[1024];
					NSInteger len= [_stream read:buf maxLength:1024]; 
					
					if (len < 0) {

						// Handle this like a stream error
						NSError *error = [_stream streamError];
						NSString *reason= [NSString stringWithFormat:@"Error code %d: %@", error.code, [error localizedDescription]];
						LSException *exception= [[LSException alloc] initWithClient:_client session:self description:@"Stream error occurred" reason:reason];
						
						[self handleStreamError:exception];
						break;

					} else if (len == 0) {

						// Handle this like an end of stream
						[self handleStreamClose];
						break;
						
					} else {

						NSString *received = [[[NSString alloc] initWithBytes:buf length:len encoding:[NSString defaultCStringEncoding]] autorelease];
						[_buffer appendString:received];
					}

				} while ([_stream hasBytesAvailable]);

				if ((!_connected) && (!_connecting))
					break;
				
				do {
					if (_connecting) {
						// We are waiting for an answer from a create session or a
						// bind session: the answer is complete only when we find
						// un the buffer two continuous linefeeds
						
						NSRange range= [_buffer rangeOfString:@"\r\n\r\n"];
						if (range.location != NSNotFound) {
							NSString *response= [_buffer substringToIndex:(range.location + range.length)];
							
							NSRange range2= {0, range.location + range.length};
							[_buffer deleteCharactersInRange:range2];
							
							if ([response hasPrefix:@"HTTP"]) {
								[self parseHttpResponse:response];
								
							} else {
								// If we have a session ID we are doing a bind session,
								// else we are doing a create session
								
								if (_sessionId) 
									[self parseBindResponse:response];
								else
									[self parseCreateResponse:response];
							}
						
						} else break;

					} else {
						// We received one or more updates,
						// we split them individually
					
						NSRange range= [_buffer rangeOfString:@"\r\n" options:NSBackwardsSearch];
						if (range.location != NSNotFound) {
							NSString *allUpdates= [_buffer substringToIndex:(range.location + range.length)];
							
							NSRange range2= {0, range.location + range.length};
							[_buffer deleteCharactersInRange:range2];
							
							NSArray *updates= [allUpdates componentsSeparatedByString:@"\r\n"];
							for (NSString *update in updates) {
								if ([update length] > 0)
									[self parseUpdate:update];
							}
						
						} else break;
					} 
					
				} while (YES);
				break; 
			} 
				
			case NSStreamEventHasSpaceAvailable: {
				if ([_command length] > 0) {
					const uint8_t *rawstring= (const uint8_t *)[_command UTF8String];
					NSInteger len= [_outStream write:rawstring maxLength:strlen((const char *)rawstring)];
					
					if (len < 0) {
						
						// Handle this like a stream error
						NSError *error = [_stream streamError];
						NSString *reason= [NSString stringWithFormat:@"Error code %d: %@", error.code, [error localizedDescription]];
						LSException *exception= [[LSException alloc] initWithClient:_client session:self description:@"Output stream error occurred" reason:reason];
						
						[self handleStreamError:exception];
						break;
						
					} else if (len == 0) {
						
						// Handle this like an end of stream
						[self handleStreamClose];
						break;
						
					} else {
						_command= [_command substringFromIndex:len];
					}
				}
				
				break;
			}
				
			case NSStreamEventErrorOccurred: { 
				NSError *error = [_stream streamError];
				NSString *reason= [NSString stringWithFormat:@"Error code %d: %@", error.code, [error localizedDescription]];
				LSException *exception= [[LSException alloc] initWithClient:_client session:self description:@"Stream error occurred" reason:reason];
				
				[self handleStreamError:exception];
				break;
			}
				
			case NSStreamEventEndEncountered: {
				[self handleStreamClose];
				break;
			}
		}
		
	} @catch (NSException *e) {
		NSLog(@"Exception caught while handling stream event: %@, name: %@, reason: %@, user info: %@", [[e class] description], [e name], [e reason], [e userInfo]);

	} @finally {
		[pool drain];
	}
}

- (void) handleStreamError:(LSException *)exception {
	if (_connected) {
		NSLog(@"Stream error occurred, reason: %@", [exception reason]);
		
		_connected= NO;
		_connectionException= exception;
		
		if (_connecting) {
			[_connecting lock];
			[_connecting signal];
			[_connecting unlock];
			
		} else 
			[_listener onException:self exception:[exception autorelease]];
	}
}

- (void) handleStreamClose {
	if (_connected) {
		NSLog(@"Stream closed");

		_connected= NO;
		_connectionException= nil;
		
		if (_connecting) {
			[_connecting lock];
			[_connecting signal];
			[_connecting unlock];
			
		} else {
			if ([_listener respondsToSelector:@selector(onSessionClose:)])
				[_listener onSessionClose:self];
		}
	}
}

- (void) parseHttpResponse:(NSString *)response {
	response= [response stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
	NSArray *lines= [response componentsSeparatedByString:@"\r\n"];

	NSString *firstLine= [lines objectAtIndex:0];
	NSArray *tokens= [firstLine componentsSeparatedByString:@" "];

	NSString *firstToken= [tokens objectAtIndex:0];
	if (![firstToken isEqualToString:@"HTTP/1.0"]) {
		_connectionException= [[LSException alloc] initWithClient:_client session:self description:@"Can't create session with Lightstreamer server" reason:@"Malformed HTTP response received"];

		[_connecting lock];
		[_connecting signal];
		[_connecting unlock];
		
		return;
	}
	
	NSString *secondToken= [tokens objectAtIndex:1];
	if (![secondToken isEqualToString:@"200"]) {
		NSString *reason= @"HTTP response code is not 200";
		@try {
			NSRange range= [firstLine rangeOfString:secondToken];
			NSString *thirdToken= [firstLine substringFromIndex:(range.location + range.length)];
			
			reason= @"HTTP response code received: ";
			reason= [reason stringByAppendingString:secondToken];
			reason= [reason stringByAppendingString:thirdToken];

		} @catch (id) {}

		_connectionException= [[LSException alloc] initWithClient:_client session:self description:@"Can't create session with Lightstreamer server" reason:reason];
		
		[_connecting lock];
		[_connecting signal];
		[_connecting unlock];
		
		return;
	}
}

- (void) parseCreateResponse:(NSString *)response {
	response= [response stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
	NSArray *lines= [response componentsSeparatedByString:@"\r\n"];

	NSString *firstLine= [lines objectAtIndex:0];
	if (![firstLine isEqualToString:@"OK"]) {
		NSString *reason= @"Lightstreamer returned ";
		reason= [reason stringByAppendingString:firstLine];
		@try {
			NSString *errorCodeLine= [lines objectAtIndex:1];
			NSString *errorMsgLine= [lines objectAtIndex:2];

			reason= @"Lightstreamer error received: ";
			reason= [reason stringByAppendingString:errorCodeLine];
			reason= [reason stringByAppendingString:@" "];
			reason= [reason stringByAppendingString:errorMsgLine];

		} @catch (id) {}

		_connectionException= [[LSException alloc] initWithClient:_client session:self description:@"Can't create session with Lightstreamer server" reason:reason];
		
		[_connecting lock];
		[_connecting signal];
		[_connecting unlock];
		
		return;
	}
	
	for (NSString *line in lines) {
		if ([line hasPrefix:@"SessionId"]) {
			NSRange range= [line rangeOfString:@":"];
			
			_sessionId= [[line substringFromIndex:(range.location + range.length)] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];			
			[_sessionId retain];

		} else if ([line hasPrefix:@"ControlAddress"]) {
			NSRange range= [line rangeOfString:@":"];
			
			NSString *url= @"http://";
			url= [url stringByAppendingString:[[line substringFromIndex:(range.location + range.length)] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]]];
			
			_controlLink= [NSURL URLWithString:url];
			[_controlLink retain];
		}
	}
	
	[_connecting lock];
	[_connecting signal];
	[_connecting unlock];
}

- (void) parseBindResponse:(NSString *)response {
	response= [response stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
	NSArray *lines= [response componentsSeparatedByString:@"\r\n"];
	
	NSString *firstLine= [lines objectAtIndex:0];
	if (![firstLine isEqualToString:@"OK"]) {
		NSString *reason= @"Lightstreamer returned ";
		reason= [reason stringByAppendingString:firstLine];
		@try {
			NSString *errorCodeLine= [lines objectAtIndex:1];
			NSString *errorMsgLine= [lines objectAtIndex:2];
			
			reason= @"Lightstreamer error received: ";
			reason= [reason stringByAppendingString:errorCodeLine];
			reason= [reason stringByAppendingString:@" "];
			reason= [reason stringByAppendingString:errorMsgLine];
			
		} @catch (id) {}

		_connectionException= [[LSException alloc] initWithClient:_client session:self description:@"Can't bind session to Lightstreamer server" reason:reason];
		
		[_connecting lock];
		[_connecting signal];
		[_connecting unlock];
		
		return;
	}

	for (NSString *line in lines) {
		if ([line hasPrefix:@"ControlAddress"]) {
			NSRange range= [line rangeOfString:@":"];
			
			NSString *url= @"http://";
			[url stringByAppendingString:[[line substringFromIndex:(range.location + range.length)] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]]];
			
			[_controlLink autorelease];
			_controlLink= [NSURL URLWithString:url];
			[_controlLink retain];
		}
	}

	[_connecting lock];
	[_connecting signal];
	[_connecting unlock];
}

- (void) parseUpdate:(NSString *)update {
	if ([update hasPrefix:@"PROBE"]) {
		if ([_listener respondsToSelector:@selector(onProbe:)])
			[_listener onProbe:self];
		
	} else if ([update hasPrefix:@"LOOP"]) {
		_connected= NO;
		_loopReceived= YES;

		if ([_listener respondsToSelector:@selector(onLoop:holdingTime:)]) {
			if ([update length] > 4) {
				NSString *holdingTime= [update substringFromIndex:4];
				[_listener onLoop:self holdingTime:[holdingTime integerValue]];

			} else {
				[_listener onLoop:self holdingTime:0];
			}
		}
		
	} else {
		NSRange firstPipe= [update rangeOfString:@"|"];
		if (firstPipe.location == NSNotFound) {
			// This is and end-of-snapshot signal, or an overflow,
			// we distinguish the cases from the prefix
			
			NSRange firstComma= [update rangeOfString:@","];
			if (firstComma.location == NSNotFound) {
				NSLog(@"Malformed update received: %@", update);
				return;
			}

			NSString *window= [update substringToIndex:firstComma.location];
			
			NSRange secondComma= { firstComma.location +1, [update length] -firstComma.location -1 };
			secondComma= [update rangeOfString:@"," options:NSLiteralSearch range:secondComma];
			if (secondComma.location == NSNotFound) {
				NSLog(@"Malformed update received: %@", update);
				return;
			}
			
			NSRange tableRange= { firstComma.location +1, secondComma.location -firstComma.location -1};
			NSString *table= [update substringWithRange:tableRange];
			
			NSRange thirdComma= { secondComma.location +1, [update length] -secondComma.location -1 };
			thirdComma= [update rangeOfString:@"," options:NSLiteralSearch range:thirdComma];
			if (thirdComma.location == NSNotFound) {
				NSLog(@"Malformed update received: %@", update);
				return;
			}
			
			NSRange itemRange= { secondComma.location +1, thirdComma.location -secondComma.location -1 };
			NSString *item= [update substringWithRange:itemRange];
			
			NSString *signal= [update substringFromIndex:thirdComma.location +1];
			
			if ([signal hasPrefix:@"EOS"]) {
				if ([_listener respondsToSelector:@selector(onEndOfSnapshot:window:table:item:)])
					[_listener onEndOfSnapshot:self window:[window integerValue] table:[table integerValue] item:[item integerValue]];
				
			} else if ([signal hasPrefix:@"OV"]) {
				NSString *size= [signal substringFromIndex:2];
				
				if ([_listener respondsToSelector:@selector(onOverflow:window:table:item:overflowSize:)])
					[_listener onOverflow:self window:[window integerValue] table:[table integerValue] item:[item integerValue] overflowSize:[size integerValue]];
				
			} else {
				NSLog(@"Malformed update received: %@", update);
			}

		} else {
			// This is an update, we split it using pipes and
			// then separating each value

			NSRange firstComma= [update rangeOfString:@","];
			if (firstComma.location == NSNotFound) {
				NSLog(@"Malformed update received: %@", update);
				return;
			}
			
			NSString *window= [update substringToIndex:firstComma.location];
			
			NSRange secondComma= { firstComma.location +1, [update length] -firstComma.location -1 };
			secondComma= [update rangeOfString:@"," options:NSLiteralSearch range:secondComma];
			if (secondComma.location == NSNotFound) {
				NSLog(@"Malformed update received: %@", update);
				return;
			}
			
			NSRange tableRange= { firstComma.location +1, secondComma.location -firstComma.location -1};
			NSString *table= [update substringWithRange:tableRange];

			NSRange itemRange= { secondComma.location +1, firstPipe.location -secondComma.location -1 };
			NSString *item= [update substringWithRange:itemRange];

			NSString *values= [update substringFromIndex:firstPipe.location +1];
			
			NSArray *valuesArray= [values componentsSeparatedByString:@"|"];
			NSMutableArray *unescapedValuesArray= [NSMutableArray arrayWithCapacity:[valuesArray count]];
			for (NSString *value in valuesArray) {
				if ([value isEqualToString:@"$"]) {
					// Empty value, we use an empty string

					[unescapedValuesArray addObject:@""];
					
				} else if ([value isEqualToString:@"#"]) {
					// Null value, we use the NSNull

					[unescapedValuesArray addObject:[NSNull null]];
					
				} else if ([value length] > 0) {
					// Generic value, has to be decoded with
					// Unicode-encoding and passed as it is

					[unescapedValuesArray addObject:[LSSession unescapeUnicodeString:value]];
					
				} else {
					// Unchanged value, we use a singleton
					// similar to the NSNull
					
					[unescapedValuesArray addObject:[LSUnchangedValue unchangedValue]];
				}
			}
			
			[_listener onUpdate:self window:[window integerValue] table:[table integerValue] item:[item integerValue] values:unescapedValuesArray];
		}
	}
}

- (void) control:(NSString *)path query:(NSString *)query {
	if (!_connected)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't control session" reason:@"Session is not connected"] autorelease];
	
	if (!_sessionId)
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't control session" reason:@"Session has no valid session ID"] autorelease];
	
	NSString *url= [self.controlLink absoluteString];
	if (![url hasSuffix:@"/"]) url= [url stringByAppendingString:@"/"];
	url= [url stringByAppendingString:path];
	
	NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
	NSString *queryLength = [NSString stringWithFormat:@"%d", [queryData length]];
	
	NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	[request setValue:_host forHTTPHeaderField:@"Host"];
	[request setValue:@"iStreamLight 1.0.6/iOS" forHTTPHeaderField:@"User-Agent"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:queryLength forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:queryData];
	
	NSHTTPURLResponse *response= nil;
	NSError *error= nil;
	NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	[request release];
	
	if (error) {
		NSString *reason= @"URL connection returned error: ";
		reason= [reason stringByAppendingString:[error description]];
		
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't control session" reason:reason] autorelease];
	}
	
	if (response) {
		NSInteger statusCode= [response statusCode];
		if (statusCode != 200) {
			NSString *reason= @"Lightstreamer returned HTTP status code: ";
			reason= [reason stringByAppendingFormat:@"%d", statusCode];
			
			@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't control session" reason:reason] autorelease];
		}
	}
	
	NSString *result = [[[NSString alloc] initWithData:data encoding:[NSString defaultCStringEncoding]] autorelease];
	result= [result stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \r\n"]];
	
	if (![result isEqualToString:@"OK"]) {
		NSString *reason= @"Lightstreamer returned ";
		reason= [reason stringByAppendingString:result];
		@try {
			NSArray *lines= [result componentsSeparatedByString:@"\r\n"];
			
			NSString *errorCodeLine= [lines objectAtIndex:1];
			NSString *errorMsgLine= [lines objectAtIndex:2];
			
			reason= @"Lightstreamer error received: ";
			reason= [reason stringByAppendingString:errorCodeLine];
			reason= [reason stringByAppendingString:@" "];
			reason= [reason stringByAppendingString:errorMsgLine];
			
		} @catch (id) {}
		
		@throw [[[LSException alloc] initWithClient:_client session:self description:@"Can't control session" reason:reason] autorelease];
	}
}

+ (NSString *) unescapeUnicodeString:(NSString *)escapedString {
	NSMutableString *string= [[NSMutableString alloc] initWithString:escapedString];
	
	do {
		NSRange escapeRange= [string rangeOfString:@"\\u"];
		if (escapeRange.location == NSNotFound)
			break;
		
		if ((escapeRange.location +6) >= [string length])
			break;
		
		NSRange hexRange= { escapeRange.location +2, 4 };
		NSString *hexCode= [string substringWithRange:hexRange];
		
		unsigned int hexValue= 0;
		NSScanner *scanner= [NSScanner scannerWithString:hexCode];
		BOOL ok= [scanner scanHexInt:&hexValue];
		if (!ok)
			break;
		
		unichar ch= (unichar) hexValue;
		NSString *chString= [[NSString alloc] initWithCharacters:&ch length:1];
		
		NSRange replaceRange= { escapeRange.location, 6 };
		[string replaceCharactersInRange:replaceRange withString:chString];
		
		[chString release];
		
	} while (YES);
	
	return [string autorelease];
}

@end
