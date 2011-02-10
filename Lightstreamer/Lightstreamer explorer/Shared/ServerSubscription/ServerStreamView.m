//
//  ServerStreamView.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerStreamView.h"


@implementation ServerStreamView

#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self) {
		_table = nil;
		_toolbar = nil;
		_fixedSpace = nil;
		_flexibleSpaceLeft = nil;
		_title = nil;
		_flexibleSpaceRight = nil;
		_close = nil;
	}
	
	return self;
}

- (void) dealloc {
	
	[_table release];
	[_toolbar release];
	[_fixedSpace release];
	[_flexibleSpaceLeft release];
	[_title release];
	[_flexibleSpaceRight release];
	[_close release];
	[super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize table = _table;
@synthesize toolbar = _toolbar;
@synthesize fixedSpace = _fixedSpace;
@synthesize flexibleSpaceLeft = _flexibleSpaceLeft;
@synthesize title = _title;
@synthesize flexibleSpaceRight = _flexibleSpaceRight;
@synthesize close = _close;

@end
