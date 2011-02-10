//
//  EditableCell.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "EditableCell.h"


@implementation EditableCell


#pragma mark -
#pragma mark Initialization

- (id) initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if (self) {
		
		_cellLabel = nil;
		_cellField = nil;
	}
	
	return self;
}


- (void) dealloc {
	
	[_cellLabel release];
	[_cellField release];
    [super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize cellLabel= _cellLabel;
@synthesize cellField= _cellField;


@end
