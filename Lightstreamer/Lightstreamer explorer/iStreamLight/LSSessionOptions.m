//
//  LSSessionOptions.m
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
#import "LSSessionOptions.h"


@implementation LSSessionOptions

@synthesize requestedMaxBandwidth= _requestedMaxBandwidth;
@synthesize topMaxFrequency= _topMaxFrequency;
@synthesize contentLength= _contentLength;
@synthesize keepAliveMillis= _keepAliveMillis;
@synthesize reportInfo= _reportInfo;
@synthesize polling= _polling;
@synthesize pollingMillis= _pollingMillis;
@synthesize idleMillis= _idleMillis;

- (id) init {
	[super init];
	
	_requestedMaxBandwidth= 0.0;
	_topMaxFrequency= 0.0;
	_contentLength= 0;
	_keepAliveMillis= 0;
	_reportInfo= NO;
	_polling= NO;
	_pollingMillis= 0;
	_idleMillis= 0;
	
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	LSSessionOptions *copy= [[LSSessionOptions alloc] init];
	
	copy.requestedMaxBandwidth= _requestedMaxBandwidth;
	copy.topMaxFrequency= _topMaxFrequency;
	copy.contentLength= _contentLength;
	copy.keepAliveMillis= _keepAliveMillis;
	copy.reportInfo= _reportInfo;
	copy.polling= _polling;
	copy.pollingMillis= _pollingMillis;
	copy.idleMillis= _idleMillis;
	
	return copy;
}

@end;
