//
//  ItemState.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ItemState.h"


@implementation ItemState


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) init {

	self = [super init];
	if (self) {
		_toUpdate = NO;
		_value = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void) dealloc {

	[_value release];
	[super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize toUpdate = _toUpdate;
@synthesize value = _value;

@end
