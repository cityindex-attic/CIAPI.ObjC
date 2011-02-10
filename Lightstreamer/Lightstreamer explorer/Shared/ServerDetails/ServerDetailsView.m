//
//  ServerDetailsView.m
//
//  Created by Marco Vannucci on 03/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerDetailsView.h"


@implementation ServerDetailsView


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
