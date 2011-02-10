//
//  ServerListViewController.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LSExpPopoverManagement.h";

@class ServerConfig;
@interface ServerListViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private
	// Manage the result returned from Core Data fetch request
	NSFetchedResultsController *_fetchedResultsController;
	// Keep trace of the selected row in the table
	NSIndexPath *_selectedRow;
}

#pragma mark -
#pragma mark Core Data support

// Apply the Code Data fetch query
- (void) performFetch;


#pragma mark -
#pragma mark Internal methods

// New Server button action
- (void) addServer;

// Show server detail view of passed server as new view of navigation (iPhone) or in detail view (iPad).
- (void) showServerDetailsViewOfServer:(ServerConfig *)server;

// This method is called when the detail view of split view is exchaged from server details to server subscription or vice-versa.
- (void) showOnIPadDetailViewThisViewControler:(UIViewController <LSExpPopoverManagement, UISplitViewControllerDelegate> *)toShow;

// Selector of persistent context changes
- (void) contextChanged;


#pragma mark -
#pragma mark Properties

// The row selected in the table. For an startup issue, on change of this property the row of the table is not selected.
// It is necessary send the selectRowAtIndexPath:animated:scrollPosition: message to the table view object
@property (nonatomic, retain) NSIndexPath *selectedRow;

// Result of Core Data fetch request
@property (readonly) NSFetchedResultsController *fetchedResultsController;

@end
