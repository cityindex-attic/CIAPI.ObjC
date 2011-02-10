//
//  ServerDetailsViewController.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewControllerWithTextFields.h"
#import "LSExpPopoverManagement.h"

@class ServerConfig;
@interface ServerDetailsViewController : TableViewControllerWithTextFields <UISplitViewControllerDelegate, LSExpPopoverManagement> {

@private
	// Server to show the details
	ServerConfig *_server;
	// Dictionary containing the temporary values of server
	NSMutableDictionary *_tmpValues;
	// This values must be set to nil, through the property, when a change has been applied
	BOOL _changesApplied;
	// Controller of the popover on iPad application
	UIPopoverController *_popOverController;
	// Used in viewWillDisappear method. This value is false when view disapper due to new push on navigation controller
	BOOL _exitingFromView;
}

#pragma mark Internal use methods

// Save button action selector
-(void) save;

// Table's cells rendering methods
-(UITableViewCell *)standardViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row;
-(UITableViewCell *)editableViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row;

#pragma mark -
#pragma mark Properties

// This property must be set a true in any case of value detail change on the server
@property BOOL changesApplied;

@end
