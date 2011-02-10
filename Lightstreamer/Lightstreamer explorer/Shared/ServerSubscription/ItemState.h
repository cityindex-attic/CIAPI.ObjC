//
//  ItemState.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


// Store the values and the state of a field
@interface ItemState : NSObject {

@private
	// Related to the property
	BOOL _toUpdate;
	// Related to the property
	NSMutableArray *_value;
}

#pragma mark -
#pragma mark Properties

// The state of the field
@property BOOL toUpdate;
// Values of the field
@property (retain) NSMutableArray *value;

@end
