//
//  LSClient.m
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
#import "LSClient.h"
#import "LSListener.h"
#import "LSSessionOptions.h"
#import "LSSession.h"
#import "LSSession+Internals.h"
#import "LSException.h"


@implementation LSClient

@synthesize serverURL= _serverURL;

- (LSClient *) initWithServerURL:(NSURL *)serverURL {
	[super init];

	_serverURL= [serverURL retain];
	
	return self;
}

- (void) dealloc {
	[_serverURL release];
	
	[super dealloc];
}

- (LSSession *) createSession:(NSString *)user password:(NSString *)password adapterSet:(NSString *)adapterSet listener:(id<LSListener>)listener options:(LSSessionOptions *)options autorebind:(BOOL)autorebind {
	LSSession *session= [[LSSession alloc] init];

	BOOL secure= NO;
	if ([[_serverURL scheme] isEqualToString:@"https"]) 
		secure= YES;
	
	NSString *host= [_serverURL host];
	
	NSInteger port= [[_serverURL port] integerValue];
	if (port == 0) 
		port= (secure ? 443 : 80);
	
	[session create:self host:host port:port secure:secure user:user password:password adapterSet:adapterSet listener:listener options:options autorebind:autorebind];
	
	return [session autorelease];
}

- (void) bindSession:(LSSession *)session options:(LSSessionOptions *)options {
	BOOL secure= NO;
	if ([[_serverURL scheme] isEqualToString:@"https"]) 
		secure= YES;
	
	NSString *host= [_serverURL host];
	
	NSInteger port= [[_serverURL port] integerValue];
	if (port == 0) 
		port= (secure ? 443 : 80);
	
	[session bind:host port:port secure:secure options:options];
}

- (void) killSessions:(NSString *)user password:(NSString *)password adapterSet:(NSString *)adapterSet {
	NSString *url= [_serverURL absoluteString];
	if (![url hasSuffix:@"/"]) url= [url stringByAppendingString:@"/"];
	url= [url stringByAppendingString:@"lightstreamer/kill.txt"];
	
	NSString *query= @"";
	query= [query stringByAppendingFormat:@"LS_user=%@", ((user == nil) ? @"" : [user stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])];
	if (password) 
		query= [query stringByAppendingFormat:@"&LS_password=%@", [password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	if (adapterSet) 
		query= [query stringByAppendingFormat:@"&LS_adapter=%@", [adapterSet stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
	NSString *queryLength = [NSString stringWithFormat:@"%d", [queryData length]];
	
	NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	[request setValue:[_serverURL host] forHTTPHeaderField:@"Host"];
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
		
		@throw [[[LSException alloc] initWithClient:self description:@"Can't kill sessions" reason:reason] autorelease];
	}
	
	if (response) {
		NSInteger statusCode= [response statusCode];
		if (statusCode != 200) {
			NSString *reason= @"Lightstreamer returned HTTP status code: ";
			reason= [reason stringByAppendingFormat:@"%d", statusCode];
			
			@throw [[[LSException alloc] initWithClient:self description:@"Can't kill sessions" reason:reason] autorelease];
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
		
		@throw [[[LSException alloc] initWithClient:self description:@"Can't kill sessions" reason:reason] autorelease];
	}
}

@end
