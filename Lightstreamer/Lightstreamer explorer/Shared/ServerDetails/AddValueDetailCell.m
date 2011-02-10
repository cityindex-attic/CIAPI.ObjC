//
//  AddValueDetailCell.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 08/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "AddValueDetailCell.h"


@implementation AddValueDetailCell

#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self)
		_cellField = nil;
	
	return self;
}

- (void) dealloc {
	
	[_cellField release];
    [super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize cellField= _cellField;

@end
