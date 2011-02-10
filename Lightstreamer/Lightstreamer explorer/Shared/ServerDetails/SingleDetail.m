//
//  SingleDetail.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 11/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "SingleDetail.h"

@implementation SingleDetail

#pragma mark -
#pragma mark Initializzation and Deallocation

- (id) init {
	
	self = [super init];
	if (self) {
		_server = nil;
		_valuesClassName = nil;
		_propertyName = nil;
		_addValuesSelector = nil;
		_removeValueSelector = nil;
		_previousViewController = nil;
	}
	
	return self;
}


- (void) dealloc {
	
	[_server release];
	[_valuesClassName release];
	[_propertyName release];
	[_previousViewController release];
	[super dealloc];
}


#pragma mark -
#pragma mark Properties

@synthesize server = _server;
@synthesize valuesClassName = _valuesClassName;
@synthesize valuesName = _valuesName;
@synthesize propertyName = _propertyName;
@synthesize addValuesSelector = _addValuesSelector;
@synthesize removeValueSelector = _removeValueSelector;

@synthesize previousViewController = _previousViewController;

@end
