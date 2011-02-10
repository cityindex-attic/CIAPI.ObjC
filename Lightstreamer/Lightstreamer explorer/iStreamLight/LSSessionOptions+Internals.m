//
//  LSSessionOptions+Internals.m
//  iStreamLight v. 1.0.6
//
//  Created by Gianluca Bertani on 09/07/08.
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
#import "LSSessionOptions+Internals.h"


@implementation LSSessionOptions (Internals)

- (NSString *) appendToQueryString:(NSString *)query {
	if (_requestedMaxBandwidth) {
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingFormat:@"LS_requested_max_bandwidth=%.2lf", _requestedMaxBandwidth];
	}
	
	if (_topMaxFrequency) {
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingFormat:@"LS_top_max_frequency=%.2lf", _topMaxFrequency];
	}
	
	if (_contentLength) {
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingFormat:@"LS_content_length=%d", _contentLength];
	}
	
	if (_keepAliveMillis) {
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingFormat:@"LS_keepalive_millis=%d", _keepAliveMillis];
	}
	
	if (_reportInfo) {
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingString:@"LS_report_info=true"];
	}
	
	if (_polling) { 
		if ([query length] > 0) query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingString:@"LS_polling=true"];
		
		query= [query stringByAppendingString:@"&"];
		query= [query stringByAppendingFormat:@"LS_polling_millis=%d", _pollingMillis];
		
		if (_idleMillis) {
			query= [query stringByAppendingString:@"&"];
			query= [query stringByAppendingFormat:@"LS_idle_millis=%d", _idleMillis];
		}
	}
	
	return query;
}

@end
