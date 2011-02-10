    //
//  DetailSelectionViewController.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 14/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "DetailSelectionViewController.h"
#import "DetailSelectionView.h"
#import "Macros.h"
#import <math.h>


#define STATUS_BAR_HEIGTH 20 //Status bar is 20 px height

@implementation DetailSelectionViewController

#pragma mark -
#pragma mark Initialization and Deallocation

- (id)initWithValues:(NSArray *)valuesArray orientation:(UIDeviceOrientation)aOrientation andDefineKey:(NSString *)key onObject:(NSObject *)obj {
	
	self = [super init];
	if (self) {
		// Definize initial value of attribute
		_values = [valuesArray retain];
		_selectedValue = nil;
		_key = [key retain];
		_toDefine = [obj retain];
		
		if (!_values)
			_values = [[NSArray alloc] init];
		
		_orientation = aOrientation;
	}
	return self;	
}


- (void)dealloc {
	
	[_selectedValue release];
	[_values release];
	[_key release];
	[_toDefine release];
    [super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {

	// Load view from nib file
	DetailSelectionView *detailSelectionView = [[[NSBundle mainBundle] loadNibNamed:@"DetailSelectionView" owner:self options:nil] lastObject];	
	
	// Set this view controller as table's delegate and data source	
	detailSelectionView.values.dataSource = self;
	detailSelectionView.values.delegate = self;	
	
	// Set action selector for buttons
	detailSelectionView.cancelButton.action = @selector(cancel);
	detailSelectionView.cancelButton.target = self;
	detailSelectionView.doneButton.action = @selector(done);
	detailSelectionView.doneButton.target = self;
	
	// On iPhone set the view and return
	if (!DEVICE_IPAD) {
		self.view = detailSelectionView;
		return;
	}
	
	// On iPad the view to show is only the container view	
	// Set the container's origin in the up/left corner
	CGRect frame = detailSelectionView.container.frame;
	frame.origin.y = 0;
	detailSelectionView.container.frame = frame;
	self.view = detailSelectionView.container;
}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	if (DEVICE_IPAD)
		return;
	
	// On iPhone detail selection view is connected to the window. After the first window view, any other view is not notified
	// of application rotation. So it is necessary apply view rotation manually. This view controller will be notified of other application
	// rotation by server subscription view controller on orientation property.
	
	switch (_orientation) {
		case UIDeviceOrientationPortraitUpsideDown:
			[self transformIntoPortraitUpsideDown];
			break;
		case UIDeviceOrientationLandscapeLeft:
			[self transformIntoLandscapeLeft];
			break;
		case UIDeviceOrientationLandscapeRight:
			[self transformIntoLandscapeRight]; 	
			break;
		default:
			//case of UIDeviceOrientationPortrait, UIDeviceOrientationFaceUp, UIDeviceOrientationFaceDown, UIDeviceOrientationUnknow
			[self transformIntoPortrait];
	}
	
	// Show the slide up animation on picker view
	[self slideUpPickerView];
}


#pragma mark -
#pragma mark Methods of UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	// One column in picker view
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

	// The number of detail values
	return [_values count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	// The value at index path
	return [_values objectAtIndex:row];
}


#pragma mark -
#pragma mark Methods of UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

	// Take trace of user selection
	_selectedValue = [_values objectAtIndex:row];
}


#pragma mark -
#pragma mark Toolbar button actions

- (void) cancel {
	
	// Invalidate selected value and complete the action
	_selectedValue = nil;
	[self performAction];
}


- (void) done {
	
	// If nothing has been tapped but the list is not empty than the selected value is the first
	if (_selectedValue == nil && ([_values count] != 0))
		_selectedValue = [_values objectAtIndex:0];
	
	// Complete the action
	[self performAction];
}


#pragma mark -
#pragma mark Internal methods

- (void) performAction {
	
	// Nofity server subscription view controller which of the selected value
	[_toDefine setValue:_selectedValue forKey:_key];
	
	// On iPhone slide down the picker view
	if (!DEVICE_IPAD)
		[self slideDownPickerView];
	
	// Remove the view at the end of slide down animation
	[self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3f];
}


- (void) transformIntoLandscapeRight {
	
	// Apply a 270° transformation and set landscape view
	self.view.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
	[self landscapeFrameOfViews];
}


- (void) transformIntoLandscapeLeft {
	
	// Apply a 90° transformation and set landscape view
	self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
	[self landscapeFrameOfViews];	
}


- (void) transformIntoPortrait {
	
	// Apply a 0° transformation and set portrait view
	self.view.transform = CGAffineTransformMakeRotation(0);
	[self portraitFrameOfViews:YES];
}


- (void) transformIntoPortraitUpsideDown {
	
	// Apply a 180° transformation and set portrait view
	self.view.transform = CGAffineTransformMakeRotation(M_PI);
	[self portraitFrameOfViews:NO];
}


- (void) portraitFrameOfViews:(BOOL)statusBarOnTop {
	
	// Define portrait frame
	DetailSelectionView *detailSelectionView = (DetailSelectionView *) self.view;
	detailSelectionView.frame = CGRectMake(0, statusBarOnTop ? STATUS_BAR_HEIGTH : 0, 320, 480);
	detailSelectionView.container.frame = CGRectMake(0, 200 + (statusBarOnTop ? 0 : STATUS_BAR_HEIGTH), 320, 260);
	detailSelectionView.values.frame = CGRectMake(0, 0, 320, 216);
}


- (void) landscapeFrameOfViews {

	// Define landscape frame
	DetailSelectionView *detailSelectionView = (DetailSelectionView *) self.view;
	detailSelectionView.frame = CGRectMake(0, 0, 320, 480);
	detailSelectionView.container.frame = CGRectMake(0,117, 480, 203);
	detailSelectionView.values.frame = CGRectMake(0, 0, 480, 160);
}
 

- (void) slideUpPickerView {
	
	// The container view must scroll from the bottom to the final position
	UIView *container = ((DetailSelectionView *) self.view).container;
	CGRect containerFrame = container.frame;
	CGRect originalFrame = containerFrame;
	containerFrame.origin.y += containerFrame.size.height;
	container.frame = containerFrame;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	container.frame = originalFrame;
	[UIView commitAnimations];
}


- (void) slideDownPickerView {
	
	// The container view must scroll from the initial to the bottom
	UIView *container = ((DetailSelectionView *) self.view).container;
	CGRect containerFrame = container.frame;
	containerFrame.origin.y += containerFrame.size.height;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	container.frame = containerFrame;
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark Properties

@synthesize orientation = _orientation;

- (void) setOrientation:(UIDeviceOrientation)newOrientation {
	
	// Is an int assignment, supposed to be an atomic operation
	_orientation = newOrientation;
	
	// Animate any kind of view translation and resize
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	
	switch (newOrientation) {
		case UIDeviceOrientationPortraitUpsideDown:
			[self transformIntoPortraitUpsideDown];
			break;
		case UIDeviceOrientationLandscapeLeft:
			[self transformIntoLandscapeLeft];
			break;
		case UIDeviceOrientationLandscapeRight:
			[self transformIntoLandscapeRight]; 	
			break;
		default:
			//case of UIDeviceOrientationPortrait, UIDeviceOrientationFaceUp, UIDeviceOrientationFaceDown, UIDeviceOrientationUnknow
			[self transformIntoPortrait]; 
	}
	
	[UIView commitAnimations];
}

@end
