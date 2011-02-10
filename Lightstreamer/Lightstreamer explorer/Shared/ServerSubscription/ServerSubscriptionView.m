//
//  ServerSubscriptionView.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 13/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerSubscriptionView.h"


@implementation ServerSubscriptionView

#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self) {
		_table = nil;
		_footerView = nil;
		_subscribe = nil;
		
	}
	
	return self;
}


- (void) dealloc {
   
	[_footerView release];
	[_subscribe release];	
	[_table release];
	[super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize table = _table;
@synthesize footerView = _footerView;
@synthesize subscribe = _subscribe;

@end
