//
//  DetailSelectionView.m
//
//  Created by Marco Vannucci on 14/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "DetailSelectionView.h"

@implementation DetailSelectionView

#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self) {
		_container = nil;
		_toolbar = nil;
		_values = nil;
		_doneButton = nil;
		_cancelButton = nil;
		_flexibleSpace = nil;
	}
	
	return self;
}

- (void) dealloc {
	
	[_container release];
	[_toolbar release];
	[_values release];
	[_doneButton release];
	[_cancelButton release];
	[_flexibleSpace release];
	[super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize container = _container;
@synthesize toolbar = _toolbar;
@synthesize values = _values;
@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize flexibleSpace = _flexibleSpace;


@end
