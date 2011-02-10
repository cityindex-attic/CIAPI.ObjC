//
//  DetailSelectionViewController.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 14/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConfig.h"


@interface DetailSelectionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

@private
	// Store the range of value of the picker view
	NSArray *_values;
	// The value the user has selected. It can be nil only the possible array is empty
	NSString *_selectedValue;
	// Object and property on which notify the user selection
	NSObject *_toDefine;
	NSString *_key;
	
	// Related to the property
	UIDeviceOrientation _orientation;
}

#pragma mark Initialization

// The initialization method
- (id)initWithValues:(NSArray *)valuesArray orientation:(UIDeviceOrientation)aOrientation andDefineKey:(NSString *)key onObject:(NSObject *)obj;

#pragma mark -
#pragma mark Button actions

// Cancel button action
- (void) cancel;

// Done button action
- (void) done;

#pragma mark -
#pragma mark Internal methods

// Execute the real actions of buttons
- (void) performAction;

// Rotation management
- (void) transformIntoPortrait;
- (void) transformIntoPortraitUpsideDown;
- (void) transformIntoLandscapeRight;
- (void) transformIntoLandscapeLeft;
- (void) portraitFrameOfViews:(BOOL)statusBarOnTop;
- (void) landscapeFrameOfViews;

// Slide up and down animation of picker view
- (void) slideUpPickerView;
- (void) slideDownPickerView;

#pragma mark -
#pragma mark Properties

// Thia view is attached to the window as second subview, than this controller is not notified of application rotation.
// Orientation is the property that an other controller has to modifiy in order to change the orientation of the view
@property UIDeviceOrientation orientation;

@end
