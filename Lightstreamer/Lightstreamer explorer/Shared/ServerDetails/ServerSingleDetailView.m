//
//  ServerSingleDetailViewController.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 06/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerSingleDetailView.h"


@implementation ServerSingleDetailView


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self)
		_table = nil;
	
	return self;
}

- (void) dealloc {
	
	[_table release];
    [super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize table= _table;

@end

