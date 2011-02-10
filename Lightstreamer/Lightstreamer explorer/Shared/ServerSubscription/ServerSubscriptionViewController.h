//
//  ServerSubscriptionViewController.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 13/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "TableViewControllerWithTextFields.h";
#import "ServerConfig.h";
#import "LSExpPopoverManagement.h"


@class DetailSelectionViewController;
@interface ServerSubscriptionViewController : TableViewControllerWithTextFields <UIActionSheetDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate, UISplitViewControllerDelegate, LSExpPopoverManagement> {

@private
	// Server to subscribe
	ServerConfig *_server;
	// The tapped index path when picker view apper
	NSIndexPath *_activeIndexPath;
	// Related to the property
	NSString *_selectedValue;
	// Array of possible value of mode server attribute
	NSArray *_modeValues;
	// picker view controller
	DetailSelectionViewController *_detailSelection;
	// Rappresent one to one the attribute value to show on the 1 to 6 rows
	NSMutableArray *_doubleFields;
	//  Used to take in care the application orientation when picker view appear and disapper
	UIDeviceOrientation _orientation;
	// Popover controller in case of iPad potrait orientation
	UIPopoverController *_popOverController;
	// Popover controller of picker view in case of iPad application
	UIPopoverController *_detailpopOverController;
}

#pragma mark -
#pragma mark Button actions

// Subscription button action
- (void) subscribe;

// Action button action
- (void) action;

#pragma mark -
#pragma mark Internal Methods

// Table's cells rendering methods
- (UITableViewCell *)editableViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row;
- (UITableViewCell *)standardViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row;

// reduce and reload the table view bounds when the picker view appear and disapper
- (void) reduceTableViewHeigth;
- (void) restoreTableViewHeight;

// Slide the table view in order to show the cell at index path _activeIndexPath on top
- (void) showSelectedIndexPathOnTop;
// View to show in case of empty server list
- (UIView *) viewToShowOnEmptyServerList;

// Methods to define the _doubleFields variable
- (void) defineDoubleFields;
- (void) defineDoubleFieldForSet:(NSSet *)set andValue:(NSString *)value;
- (BOOL) set:(NSSet *)set containsValue:(NSString *)value;

// Method from which retrive email subject and body 
- (NSString *) emailSubject;
- (NSString *) emailBody;

// Used to complete the body of an email in order to verify if a property contain a value
- (BOOL) stringContainAValue:(NSString *)string;

#pragma mark -
#pragma mark Properties

// Picker view controller set this property with the value selected by the user
@property (nonatomic, retain) NSString *selectedValue;

@end
