//
//  ServerSingleDetailViewController.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 06/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewControllerWithTextFields.h"
#import "SingleDetail.h"


@interface ServerSingleDetailViewController : TableViewControllerWithTextFields {

@private
	// Contain every information neede to retrive and modify the values to show
	SingleDetail *_detail;
	
	// Contains temporary values
	NSMutableArray *_tmpValues;
	// Take trace of any added value
	NSMutableArray *_added;
	// Take trace of any removed value
	NSMutableArray *_removed;
	
	// Used to show, in editing mode, editing cell (true case) or the "Add new <detail>" cell (false case)
	BOOL _showAddValueCell;
}

#pragma mark -
#pragma mark Initialization methods

// Is the initialization method to use. It require only the filled SingleDetail object
- (id)initWithDetail:(SingleDetail *)detail;

#pragma mark -
#pragma mark Internal methods

// Bring the table view in non editing mode and set the right button title to "Edit"
- (void)viewMode;
// Bring the table view in editing mode and set the right button title to "Done"
- (void)editMode;

// Method called from table datasource delegate in order to show, in editing mode, the "Add new <detail>" cell or the editing cell
- (UITableViewCell *)showLastEditingCell;

// Method called from table datasource delegate in order to show every simple value
- (UITableViewCell *)showDefaultCellWithLabel:(NSString *)labelValue;

@end
