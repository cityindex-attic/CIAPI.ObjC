//
//  TableViewControllerWithTextFields.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 09/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "TableViewControllerWithTextFields.h"


@implementation TableViewControllerWithTextFields


#pragma mark -
#pragma mark Initialization and Deallocation


- (id)initWithStyle:(UITableViewStyle)style {
  
	self = [super initWithStyle:style];
    if (self) {
		_activeField = nil;
		keyboardIsShowing = NO;
    }
    return self;
}


- (void)dealloc {
	
	[_activeField release];
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void)viewWillAppear:(BOOL)animated {
		
	// Become observer of keyboard show and hide events. It is necessary to be nofied in order to make visible the field to edit
	// through the table scroll view
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
	
	// Unregister observer of keyboard show and hide notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewWillDisappear:animated];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	// Take trace of the text field that is in editing mode
	_activeField = [textField retain];
	
	// If the keayboard is alredy visible, in case the user has just edited another textfield, it is necessary to make
	// the new active text field visible
	if (keyboardIsShowing)
		[self centerTextField];
}


-  (void)textFieldDidEndEditing:(UITextField *)textField {
	
	// Text field is no more active, erase the taken trace
	[_activeField release];
	_activeField = nil;
}


#pragma mark Keyboard notification selectors

-(void) keyboardWillShow:(NSNotification *)note {
	
	// If the keayboard is already visible there is nothing to do.
	if (keyboardIsShowing)
		return;
	
	// Keep trace that the keyboard is visible
	keyboardIsShowing = YES;
	
	// Obtain keyboard bounds and sliding up animation duration
	CGRect keyboardBounds;
	[[[note userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	
	// Resize the table view frame to the visible are, applying the specular scratch animation of the keyboard
	CGRect frame = self.view.frame;
	frame.size.height -= keyboardBounds.size.height;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	self.view.frame = frame;
	[UIView commitAnimations];
	
	// Scroll the active text field in the visible area
	[self centerTextField];
}


- (void)keyboardWillHide:(NSNotification*)note {
    
	if (!keyboardIsShowing)
		return;
	
	// Keep trace that the keyboard is no more visible
	keyboardIsShowing = NO;
	
	// Obtain keyboard bounds and sliding down animation duration
	CGRect keyboardBounds;
	[[[note userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	NSTimeInterval animationDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	// Resize the table view frame complete area, applying the specular scratch animation of the keyboard
	CGRect frame = self.view.frame;
	frame.size.height += keyboardBounds.size.height;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:animationDuration];
	self.view.frame = frame;
	[UIView commitAnimations];
}


#pragma mark Keyboard done button action selector

-(void) didPushKeyboardDone:(id)sender {
	
	// Hide the keyboard
	[((UITextField *) sender) resignFirstResponder];
}


#pragma mark Utility to scroll a cell in visible area

- (void) centerTextField {
	
	// Scroll the text field cell to the table view middle position
	UITableView *table = nil;
	for (UIView *subview in [self.view subviews]) {
		if ([subview isKindOfClass:[UITableView class]]) {
			table = (UITableView *) subview;
			break;			
		}
	}

	UITableViewCell *cell = (UITableViewCell*) [[_activeField superview] superview];
    [table scrollToRowAtIndexPath:[table indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

@end
