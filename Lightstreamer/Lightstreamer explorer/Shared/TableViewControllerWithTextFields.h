//
//  TableViewControllerWithTextFields.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 09/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

// This is an abstract class which manage the srolling and the resizing system of a view when the keyboard appear.
@interface TableViewControllerWithTextFields : UITableViewController <UITextFieldDelegate> {

@protected
	// The field on which the keyboard is active
	UITextField *_activeField;
	// Boolean property. Is true if the keyboard is visible
	BOOL keyboardIsShowing;
}

#pragma mark -
#pragma mark Internal methods

// Keyboard notification selectors
-(void) keyboardWillShow:(NSNotification *)note;
- (void)keyboardWillHide:(NSNotification*)note;

// Keyboard done button action selector
-(void) didPushKeyboardDone:(id)sender;

// Utility to scroll a cell in visible area
-(void)centerTextField;

@end
