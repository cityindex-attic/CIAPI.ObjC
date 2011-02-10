//
//  ServerSingleDetailViewController.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 06/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerSingleDetailViewController.h"
#import "ServerSingleDetailView.h"
#import "AppDelegate_Shared.h"
#import "AddValueDetailCell.h"
#import "EditableCell.h"


@implementation ServerSingleDetailViewController


#pragma mark -
#pragma mark Initialization and Deallocation


- (id)initWithDetail:(SingleDetail *)detail {
	
	self = [super init];
	if (self) {
		// Initialize the attributes
		_detail = [detail retain];
		_showAddValueCell = NO;
		_added = [[NSMutableArray alloc] init];
		_removed = [[NSMutableArray alloc] init];
		
		// Initialize temporary values with the server ones or, if not exist, with an emty mutable array
		NSSet *values = [_detail.server valueForKey:_detail.propertyName];
		if (values)
			_tmpValues = [[[values allObjects] mutableCopy] retain];
		else
			_tmpValues = [[NSMutableArray alloc] init];
		
		// Sort by ascending, caseinsensitive name the temporary values
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
		NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
		[sortDescriptor release];
		[_tmpValues sortUsingDescriptors:descriptors];
		
		// Define title view
		self.title = _detail.valuesName;
	}
	
	return self;
}


-(void)dealloc {
	
	[_detail release];
	[_added release];
	[_removed release];
	[_tmpValues release];
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {
	
	// Load view from nib file
	ServerSingleDetailView *serverSingleDetailView = [[[NSBundle mainBundle] loadNibNamed:@"ServerSingleDetailView" owner:self options:nil] lastObject];
	self.view = serverSingleDetailView;
	
	// Set this view controller as table's delegate and data source	
	serverSingleDetailView.table.dataSource = self;
	serverSingleDetailView.table.delegate = self;
	
	// Add edit/done button to the right side of the navigation bar
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] init];
	editButton.style = UIBarButtonItemStyleDone;
	editButton.target = self;
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
	
	[self viewMode];
}


- (void)viewWillDisappear:(BOOL)animated {

	// This method verify if has been applied some value changes from the starting server ones.
	
	NSManagedObjectContext *context = SHARED_APP_DELEGATE.managedObjectContext;

	// For every value in removed array:
	//		- if it is contained in the start value set it is necessary remove the core data relation with the server and delete the value
	//		- if it is in added array it is necessary remove this value from this last array and delete the value
	BOOL changed = NO;
	NSSet *starValues = [_detail.server valueForKey:_detail.propertyName];
	for (NSManagedObject *obj in _removed) {
		if ([starValues containsObject:obj]) {
			[_detail.server performSelector:_detail.removeValueSelector withObject:obj];
			changed = YES;
		}
		else if ([_added containsObject:obj]) {
			[_added removeObject:obj];
		}
		[context deleteObject:obj];
	}
	[_removed removeAllObjects];

	// If added array is not emty, the new values must be related with the server
	if ([_added count] != 0) {
		changed = YES;
		NSSet *valuesToAdd = [[NSSet alloc] initWithArray:_added];
		[_detail.server performSelector:_detail.addValuesSelector withObject:valuesToAdd];
		[valuesToAdd release];
	}
	
	// If nothing is changed on the server it is not necessary to apply a save operation on the previous view, 
	// because there is a rollback on the start page	
	if (changed)
		_detail.previousViewController.changesApplied = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	// This view can rotate to any direction
	return YES;
}


#pragma mark -
#pragma mark Metod of UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

	//Only one section
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	// The number of row is equal to the number of values in view mode, or the number of values + 1 in edit mode
	NSUInteger numberOfRows = [_tmpValues count];
	if (tableView.editing)
		numberOfRows++;
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// If table is in editing mode and the requested cell is the values number + 1 than the cell to show is
	// the "Add new <value>" or the editing one
	if (((ServerSingleDetailView *) self.view).table.editing && ([_tmpValues count] == indexPath.row))
		return [self showLastEditingCell];
	
	// In any other case the cell is the standard one
	NSString *labelValue = [[_tmpValues objectAtIndex:indexPath.row] valueForKey:@"name"];
	return [self showDefaultCellWithLabel:labelValue];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

	// Any row is editable
	return YES;
}
 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Resign keyboard if is active
	if (_activeField)
		[_activeField resignFirstResponder];
	
	NSArray *indexPaths = [NSArray arrayWithObject:indexPath];	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		// When showing in edit mode the editable cell, but the delete button has been tapped, than must be reload the last table row showing the 
		// the "Add new <value>" cell
		if (indexPath.row == [_tmpValues count]) {
			_showAddValueCell = NO;
			[tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
			return;
		}
			
		// In case of delete it is necessary remove values from temporary values, add it to the removed array and delete the table view row.
		NSManagedObject *valueToDelete = [_tmpValues objectAtIndex:indexPath.row];
		[_tmpValues removeObjectAtIndex:indexPath.row];
		[_removed addObject:valueToDelete];
		[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// In case of insert it is necessary reload the last cell modifing the value of showAddValueCell attribute and show the keayboard
		_showAddValueCell = YES;
		[tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
		[((AddValueDetailCell *) [tableView cellForRowAtIndexPath:indexPath]).cellField becomeFirstResponder];
	}
}


#pragma mark -
#pragma mark Methods of UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// In editing mode, only if there is the "Add new <value>" cell the editing style is Insert 
	if (([_tmpValues count] == indexPath.row) && !_showAddValueCell)
		return UITableViewCellEditingStyleInsert;
	return UITableViewCellEditingStyleDelete;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Cells are not selectables
	return nil;
}


#pragma mark -
#pragma mark Methods of UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
	[super textFieldDidEndEditing:textField];
	UITableView *table = ((ServerSingleDetailView *) self.view).table;
	
	// After have edited a new value the last cell to show is the "Add new <value>" one
	_showAddValueCell = NO;	
	
	// If inserted text is empty no value is added or created
	NSString *text = textField.text;
	if (!text || [text length] == 0) {
		NSArray *indexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[_tmpValues count] inSection:0], nil];
		[table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
		[indexPaths release];
		return;
	}
	
	// Creating new core data object, setting its attribute and adding it to the temporary value array and added array
	NSManagedObjectContext *context = [SHARED_APP_DELEGATE managedObjectContext];
	NSManagedObject *value = [NSEntityDescription insertNewObjectForEntityForName:_detail.valuesClassName inManagedObjectContext:context];
	
	[value setValue:text forKey:@"name"];
	[_tmpValues addObject:value];
	[_added addObject:value];
	
	// Reload the table with the new value, scrolling the table view to the last row
	NSUInteger numberOfItems = [_tmpValues count];
	NSIndexPath *newRow = [NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:0];
	NSArray *indexPaths = [[NSArray alloc] initWithObjects:newRow, nil];
	
	[table beginUpdates];
	[table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
	[table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
	[table endUpdates];
	[indexPaths release];
	
	NSIndexPath *addNewItemRow = [NSIndexPath indexPathForRow:numberOfItems inSection:0];
	[table scrollToRowAtIndexPath:addNewItemRow atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


#pragma mark -
#pragma mark Internal Methods

- (void)editMode {
	
	// Change button title and action
	UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
	button.title = @"Done";
	button.action = @selector(viewMode);
	
	// Making table view editable
	UITableView *table = ((ServerSingleDetailView *) self.view).table;
	[table setEditing:YES animated:YES];
	
	// Add "Add new <value>" to the button and make it visible
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_tmpValues count] inSection:0];
	[table insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
	[table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];	
}


- (void) viewMode {
	
	// Resign keyboard if it is visible
	if (_activeField)
		[_activeField resignFirstResponder];
	
	// Change button title and action
	UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
	button.title = @"Edit";
	button.action = @selector(editMode);
	
	// If the table view was in editing mode, than it is necessary make it only visible and remove the last cell
	UITableView *table = ((ServerSingleDetailView *) self.view).table;
	if (table.editing) {
		[table setEditing:NO animated:YES];
		
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_tmpValues count] inSection:0];
		NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
		[table deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
		[indexPaths release];
	}
}


- (UITableViewCell *)showLastEditingCell {
	
	// If showAddValueCell is false, than the "Add new <value>" is shown. Else it is necessary to show the add value detail cell (editable)
	if (!_showAddValueCell) {
		NSString *newValue = [[NSString alloc] initWithFormat:@"%@ %@", @"Add new", [[self.title lowercaseString] substringToIndex:([self.title length] - 1)]];
		UITableViewCell *lastEditingCell = [self showDefaultCellWithLabel:newValue];
		[newValue release];
		return lastEditingCell;
	}
	
	// At the first time we are not able to define cell identifier of a custom created cell.
	// Default behaviour is the name of the AddValueDetailCell, but in order to be sure the identifier will be set at the first nib load
	static NSString *cellIdentifier = nil;
	AddValueDetailCell *cell = (AddValueDetailCell *) [((ServerSingleDetailView *) self.view).table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
		// Load custom created UITableViewCell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddValueDetailCell" owner:self options:nil] lastObject];
		
		// At the first load the cellIdentifier will be set
		if (!cellIdentifier)
			cellIdentifier = [cell.reuseIdentifier retain];
	}
	
	// Define this object as text field delegate and selector for ending an editing session
	UITextField *textField = cell.cellField;
	textField.delegate = self;
	[textField addTarget:self action:@selector(didPushKeyboardDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	//Disable autocorrection of inserted text
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	// Disable autocapitalization
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	
	// Empty text field
	textField.text = nil;
	
	return cell;
}


- (UITableViewCell *)showDefaultCellWithLabel:(NSString *)labelValue {
	
	// Show the standard cell with the labelValue parameter as text
	static NSString *cellIdentifier = @"SingleDetail";
	
	UITableViewCell *cell = [((ServerSingleDetailView *) self.view).table dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	cell.textLabel.text = labelValue;
	return cell;
}

@end
