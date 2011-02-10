//
//  ServerSubscriptionViewController.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 13/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerSubscriptionViewController.h"
#import "EditableCell.h"
#import "ServerSubscriptionView.h"
#import "DetailSelectionViewController.h"
#import "DetailSelectionView.h"
#import "Macros.h"
#import "AppDelegate_Shared.h"
#import "AppDelegate_iPad.h"
#import "ServerStreamViewController.h"
#import "ServerListViewController.h"
#import "EditableCell.h"
#import "AdapterInfo.h"
#import "FieldInfo.h"
#import "ItemInfo.h"



#define ADAPTER_KEY @"adapter"
#define ITEM_KEY @"item"
#define SCHEMA_KEY @"schema"
#define SELECTOR_KEY @"selector"
#define MODE_KEY @"mode"
#define BUFFER_SIZE_KEY @"buffer_size"
#define MAX_FREQUENCY_KEY @"max_frequency"


@implementation ServerSubscriptionViewController

#pragma mark -
#pragma mark Initialization and Deallocation

- (id) init {
	
	self = [super init];
	if (self) {
		// Assign object attributes
		_selectedValue = nil;
		_activeIndexPath = nil;
		_detailSelection = nil;
		_orientation = UIDeviceOrientationUnknown;
		_detailpopOverController = nil;
		_server = nil;
		
		// Define possible values of mode server property
		_modeValues = [[NSArray alloc] initWithObjects:@"Raw", @"Merge", @"Distinct", @"Command", nil];
		_doubleFields = [[NSMutableArray alloc] initWithCapacity:6];
	}
	
	return self;
}


- (void) dealloc {
	
	[_server release];
	[_activeIndexPath release];
	[_selectedValue release];
	[_modeValues release];
	[_detailSelection release];
	[_doubleFields release];
	[_detailpopOverController release];
	[_popOverController release];
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {
	
	// Load view from nib file
	ServerSubscriptionView *serverSubscriptionView = [[[NSBundle mainBundle] loadNibNamed:@"ServerSubscriptionView" owner:self options:nil] lastObject];	
	self.view = serverSubscriptionView;
	
	// Set this view controller as table's delegate and data source	
	serverSubscriptionView.table.dataSource = self;
	serverSubscriptionView.table.delegate = self;
	
	// Add save button on the right side of the navigation bar. Left side has not a custom management, then the default behaviour will be assigned.
	UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];
	self.navigationItem.rightBarButtonItem = actionButton;
	[actionButton release];
	
	// Define action when the subscribe button is tapped
	[serverSubscriptionView.subscribe addTarget:self action:@selector(subscribe) forControlEvents:UIControlEventTouchUpInside];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	// Take trace of application orientation
	_orientation = interfaceOrientation;
	
	// Notify the detail selection view control, in case of iphone, when it is visible that the orientation has changed
	if (_detailSelection && !DEVICE_IPAD) {
		_detailSelection.orientation = interfaceOrientation;
		[((ServerSubscriptionView *) self.view).table scrollToRowAtIndexPath:_activeIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
	}
	
	return YES;
}


- (void)viewWillAppear:(BOOL)animated {

	// Picker view could have change some cell fields, than reload data
	[((ServerSubscriptionView *) self.view).table reloadData];
	[super viewWillAppear:animated];
}


- (void) viewWillDisappear:(BOOL)animated {
	
	// Save any change
	[(SHARED_APP_DELEGATE) saveContext];
	[super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark Methods of UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	// If server is not defined, than the table does not have to show any data
	if (!_server)
		return 0;
	
    // There are four sections
	return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	// The first two sections have two elements, the last section contains two elements
	if (section < 3)
		return 2;
	return 4;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// The first two sections contain EditableCells, the last section contains default cells
	if (((indexPath.section < 3) && (indexPath.row == 0)) ||
		((indexPath.section == 3) && (indexPath.row == 1)))
		return [self standardViewCellWithSection:indexPath.section andRow:indexPath.row];
	return [self editableViewCellWithSection:indexPath.section andRow:indexPath.row];
}


#pragma mark -
#pragma mark Methods of UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Editable cell are not selectables
	if (((indexPath.section < 3) && (indexPath.row == 0)) ||
		 ((indexPath.section == 3) && (indexPath.row == 1)))
		return indexPath;
	return nil;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// The target is to show the picker view, defining the possible values, in order to give to the user 
	// the possibility to select a value of a specifi detail
	
	// Resign keyboard if is visible
	if (_activeField) 
		[_activeField resignFirstResponder];
	
	// Take trace of active indexPath
	_activeIndexPath = [indexPath retain];
	
	// Clean the selection
	[((ServerSubscriptionView *) self.view).table deselectRowAtIndexPath:indexPath animated:YES];
    
	// Define what are the values to show into the picker view
	NSArray *valuesArray = nil;
	if (indexPath.section < 3) {
		
		NSSet *definedValues;
		switch (indexPath.section) {
			case 0:
				definedValues = _server.adapters;
				break;
			case 1:
				definedValues = _server.items;
				break;
			default:
				definedValues = _server.fields;
				break;
		}
		
		NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[definedValues count]];
		for (NSManagedObject *value in definedValues)
			[values addObject:[value valueForKey:@"name"]];
		
		[values sortUsingSelector:@selector(caseInsensitiveCompare:)];
		valuesArray = [values autorelease];
	}
	else
		valuesArray = _modeValues;
		
	// Initialize the view controller
	_detailSelection = [[DetailSelectionViewController alloc] initWithValues:valuesArray orientation:_orientation andDefineKey:@"selectedValue" onObject:self];
	
	if (DEVICE_IPAD) {
		//create a popover controller and add the detail selection view controller on it
		_detailSelection.contentSizeForViewInPopover = CGSizeMake(_detailSelection.view.frame.size.width, _detailSelection.view.frame.size.height);
		_detailpopOverController = [[UIPopoverController alloc] initWithContentViewController:_detailSelection];
		
		// Present the popover from the selected cell
		UITableViewCell *cell = [((ServerSubscriptionView *) self.view).table cellForRowAtIndexPath:indexPath];
		[_detailpopOverController presentPopoverFromRect:cell.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
	else {
		
		// Add the detail selection view to the window, reduce the table higth and make the selected cell visible
		[SHARED_APP_DELEGATE.window addSubview:_detailSelection.view];
		[self reduceTableViewHeigth];
		[self performSelector:@selector(showSelectedIndexPathOnTop) withObject:nil afterDelay:0.1f];
	}
	
	// Watch any change of the property selectedValue
	[self addObserver:self forKeyPath:@"selectedValue" options:0 context:NULL];
}


#pragma mark -
#pragma mark Methods of UITextFieldDelegate

-  (void)textFieldDidEndEditing:(UITextField *)textField {
	
	// Retrive editing cell
	UITableViewCell *cell = (UITableViewCell *) [[_activeField superview] superview];

	[super textFieldDidEndEditing:textField];
	
	// Get indexPath of cell and indexPath of dual cell
	UITableView *table = ((ServerSubscriptionView *) self.view).table;
	NSIndexPath *indexPath = [table indexPathForCell:cell];
	if (indexPath.section > 2)
		return;
	
	NSIndexPath *otherIndexPath = [NSIndexPath indexPathForRow:(1 - indexPath.row) inSection:indexPath.section];
	
	// Change the value of _doubleField variable
	NSString *text = textField.text;
	NSString *empty = [[NSString alloc] init];
	[_doubleFields replaceObjectAtIndex:(indexPath.section * 2 + 1) withObject:text];
	[_doubleFields replaceObjectAtIndex:(indexPath.section * 2) withObject:empty];
	[empty release];
	
	// Save the defined value on the server
	switch (indexPath.section) {
		case 0:
			_server.adapter = text;
			break;
		case 1:
			_server.group = text;
			break;
		default:
			_server.schema = text;
	}
	
	// Reload the dual cell
	NSArray *indexPaths = [[NSArray alloc] initWithObjects:otherIndexPath, nil];
	[table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
	[indexPaths release];
}


#pragma mark -
#pragma mark Methods of UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
	
	// Define button title and add it to the left side of the navigation bar
	barButtonItem.title = @"Servers";    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}


- (void)splitViewController:(UISplitViewController*)svc popoverController:(UIPopoverController*)pc willPresentViewController:(UIViewController *)aViewController {

	// Define popover controller
	_popOverController = [pc retain];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button {

	// Release popover controller and remove left button of the navigation bar
	[_popOverController release];
	_popOverController = nil;
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}


#pragma mark -
#pragma mark Methods of MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	// Manage errors
	if (result == MFMailComposeResultFailed)
		NSLog(@"Email compose result has failed");
		
	if (error)
		NSLog(@"Error while composing email: %@, user info: %@", error, [error userInfo]);
	
	// Dismiss modal view
	[controller dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Methods of UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		
		// Deletion button has been tapped. Before delete the server a new alert is presented to the user
		
		NSString * message = [[NSString alloc] initWithFormat:@"Server %@ is going to be deleted", _server.name];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete server" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		[message release];
		[alertView show];
		[alertView release];
	}
	else if (buttonIndex == 1) {
		
		// Duplicate button has been tapped.
		
		NSManagedObjectContext *context = SHARED_APP_DELEGATE.managedObjectContext;
		
		// Create new server and copy any attribute to it. Server name will be will be the same prefixed by "Duplicated "
		ServerConfig *newServer = [NSEntityDescription insertNewObjectForEntityForName:@"ServerConfig" inManagedObjectContext:context];
		
		NSString *newName = [[NSString alloc] initWithFormat:@"Duplicated %@", _server.name];
		newServer.name = newName;		
		newServer.adapter = _server.adapter;
		newServer.adapterSet = _server.adapterSet;
		newServer.address = _server.address;
		newServer.bufferSize = _server.bufferSize;
		newServer.group = _server.group;
		newServer.maxFrequency = _server.maxFrequency;
		newServer.mode = _server.mode;
		newServer.password = _server.password;
		newServer.schema = _server.schema;
		newServer.selector = _server.selector;
		newServer.user = _server.user;
		[newName release];
		
		// It is necessary to duplicate also any detail related to the original server and connect them to the new server
		NSMutableSet *references = [[NSMutableSet alloc] init];
		for (AdapterInfo *adapter in _server.adapters) {
			
			AdapterInfo *newAdapter = [NSEntityDescription insertNewObjectForEntityForName:@"AdapterInfo" inManagedObjectContext:context];
			newAdapter.name = adapter.name;
			[references addObject:newAdapter];
		}
		[newServer addAdapters:references];
		[references release];
		
		references = [[NSMutableSet alloc] init];
		for (ItemInfo *item in _server.items) {
			
			ItemInfo *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ItemInfo" inManagedObjectContext:context];
			newItem.name = item.name;
			[references addObject:newItem];
		}
		[newServer addItems:references];
		[references release];
		
		references = [[NSMutableSet alloc] init];
		for (FieldInfo *field in _server.fields) {
			
			FieldInfo *newField = [NSEntityDescription insertNewObjectForEntityForName:@"FieldInfo" inManagedObjectContext:context];
			newField.name = field.name;
			[references addObject:newField];
		}
		[newServer addFields:references];
		[references release];

		// Persist the new server 
		[SHARED_APP_DELEGATE saveContext];
		self.server = newServer;
		
		// If the device is the iPAd, it is necessary to select the new server in master view of the split view
		if (DEVICE_IPAD) {
			ServerListViewController *serverList = (ServerListViewController *) IPAD_APP_DELEGATE.masterNavController.topViewController;

			NSIndexPath *indexPath = [serverList.fetchedResultsController indexPathForObject:newServer];
			serverList.selectedRow = indexPath;
			[serverList.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
			return;
		}
	}
	else if (buttonIndex == 2) {
		
		// Send by mail button tapped
		
		// Show in modal view tha mail composer defining mail subject and body
		MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:[self emailSubject]];
		[controller setMessageBody:[self emailBody] isHTML:NO]; 
		[self presentModalViewController:controller animated:YES];
		[controller release];
	}
}


#pragma mark -
#pragma mark Methods of UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0)
		// Cancel button
		return;
	
	// Delete server references and than the server
	
	NSManagedObjectContext *context = SHARED_APP_DELEGATE.managedObjectContext;
	
	NSSet *references = [[NSSet alloc] initWithSet:_server.adapters];
	[_server removeAdapters:references];
	for (AdapterInfo *adapter in references)
		[context deleteObject:adapter];
	[references release];
	
	references = [[NSSet alloc] initWithSet:_server.items];
	for (ItemInfo *item in references)
		[context deleteObject:item];
	[references release];
	
	references = [[NSSet alloc] initWithSet:_server.fields];
	for (FieldInfo *field in references)
		[context deleteObject:field];
	[references release];
	
	[context deleteObject:_server];
	
	// Persist changes
	[SHARED_APP_DELEGATE saveContext];
	
	// In case iPhone device return to the server list view. In case if iPad it is necessary to show another server. If at least one server 
	// is available than the first is selected, else no server available label will be shown
	if (DEVICE_IPAD) {
		ServerListViewController *serverList = (ServerListViewController *) IPAD_APP_DELEGATE.masterNavController.topViewController;
		NSUInteger nOfServer = [[serverList.fetchedResultsController.sections objectAtIndex:0] numberOfObjects];
		if (nOfServer != 0) {
			[serverList tableView:serverList.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
			[serverList.tableView selectRowAtIndexPath:serverList.selectedRow animated:YES scrollPosition:UITableViewScrollPositionTop];
		}
		else {
			self.server = nil;
			serverList.selectedRow = nil;
		}
	}
	else	
		[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Method of NSKeyValueObserving

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	
	@try {
		// Remove the observer from the object
		[self removeObserver:self forKeyPath:keyPath];
		
		// selected value is nil, this means that the user has tapped the cancel button so no other operation to perform
		if (!_selectedValue)
			return;
		
		// Define indexPaths to reload: the _activeIndexPath must be reloaded
		NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
		[indexPathsToReload addObject:_activeIndexPath];
		
		// Define the server attributed related to the active index path
		// If the _activeIndexPath is related to the double face sections, the also the dual cell must be reloaded
		if (_activeIndexPath.section < 3) {
			switch (_activeIndexPath.section) {
				case 0:
					_server.adapter = _selectedValue;
					break;
				case 1:
					_server.group = _selectedValue;
					break;
				default:
					_server.schema = _selectedValue;
			}
			
			NSString *empty = [[NSString alloc] init];
			[_doubleFields replaceObjectAtIndex:(_activeIndexPath.section * 2) withObject:_selectedValue];
			[_doubleFields replaceObjectAtIndex:(_activeIndexPath.section * 2 + 1) withObject:empty];
			[empty release];
			
			NSIndexPath *otherIndexPath = [NSIndexPath indexPathForRow:1 inSection:_activeIndexPath.section];		
			[indexPathsToReload addObject:otherIndexPath];
		}
		else
			_server.mode = [[NSNumber alloc] initWithInt:[_modeValues indexOfObject:_selectedValue]];
		
		[((ServerSubscriptionView *) self.view).table reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
		[indexPathsToReload release];
		
	}
	@finally {
		
		// In case of iPad device the detail selection view is inside a popover, than it is necessary to dismiss it.
		// In case of iPhone it is necessary to restore the bounds of the table view
		if (DEVICE_IPAD) {
			[_detailpopOverController dismissPopoverAnimated:YES];
			[_detailpopOverController release];
			_detailpopOverController = nil;
		}
		else
			[self restoreTableViewHeight];
		
		[_detailSelection autorelease];
		_detailSelection = nil;
		
		[_activeIndexPath release];
		_activeIndexPath = nil;
	}
}


#pragma mark -
#pragma mark Button action selectors

- (void)action {
	
	// Show the options: delete, duplicate, send by mail and cancel. If it is not possible send the email than the button is not show
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Delete" otherButtonTitles:@"Duplicate", nil];
	NSUInteger cancelButtonIndex = 2;
	if ([MFMailComposeViewController canSendMail]) {
		[action addButtonWithTitle:@"Send by e-mail"];
		cancelButtonIndex++;
	}
	[action addButtonWithTitle:@"Cancel"];
	action.cancelButtonIndex = cancelButtonIndex;
	
	// In case of iPad the action sheet is a popover and it is necessary set the arrow origin to the action button.
	if (DEVICE_IPAD)
		[action showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
	else {
		[action showInView:self.view];
	}
	
	[action release];
}

- (void)subscribe {
	
	// Resign keyboard if it is visible
	if (_activeField) 
		[_activeField resignFirstResponder];
	
	// Show in a modal view the server stream view under a navigation bar
	ServerStreamViewController *srvStream = [[ServerStreamViewController alloc] initWithServer:_server];
	if (DEVICE_IPAD)
		srvStream.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:srvStream animated:YES];
	[srvStream release];
}

 
#pragma mark -
#pragma mark Internal Methods


- (UITableViewCell *)editableViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row {

	// At the first time we are not able to define cell identifier of a custom created cell.
	// These identifier will be set at the first nib load of related type
	static NSString *editableCellId = nil;
	static NSString *resizedEditableCellId = nil;
	
	NSString *cellIdentifier = editableCellId;
	if (row > 1)
		cellIdentifier = resizedEditableCellId;
	
	// Common behaviour of tableview:cellForRowAtIndexPath
	EditableCell *cell = (EditableCell *) [((ServerSubscriptionView *) self.view).table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
		// Load custom created UITableViewCell
		if (row > 1){
			cell = [[[NSBundle mainBundle] loadNibNamed:@"ResizedEditableCell" owner:self options:nil] lastObject];
			if (!resizedEditableCellId)
				resizedEditableCellId = [cell.reuseIdentifier retain];
		}
		else {
			cell = [[[NSBundle mainBundle] loadNibNamed:@"EditableCell" owner:self options:nil] lastObject];
			if (!editableCellId)
				editableCellId = [cell.reuseIdentifier retain];
		}
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
	// Define specific detail of any different editable row
	UITextField *cellField = cell.cellField;
	UIKeyboardType keyboardType = UIKeyboardTypeDefault;
	NSString *label = nil;	
	if (section == 3) {
		NSObject *value;
		switch (row) {
			case 0:
				value = _server.selector;
				label = @"Selector:";
				break;
			case 2:
				value = _server.bufferSize;
				label = @"Buffer size:";
				keyboardType = UIKeyboardTypeNumbersAndPunctuation;
				break;
			default:
				value = _server.maxFrequency;
				static int i = 1;
				label = @"Max frequency:";
				if (i == 5)
					label = nil;
				keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		}
		
		if (value) {
			NSString *printableValue = [[NSString alloc] initWithFormat:@"%@", value];
			cell.cellField.text = printableValue;
			[printableValue release];			
		}
		else 
			cell.cellField.text = nil;
	}
	else {
		label = @"Others:";
		cell.cellField.text = [_doubleFields objectAtIndex:(section * 2 + 1)];
	}
	
	cell.cellLabel.text = label;
	cell.cellField.keyboardType = keyboardType;
	
	//Disable autocorrection of inserted text
	cellField.autocorrectionType = UITextAutocorrectionTypeNo;
	// Disable autocapitalization
	cellField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	
	// Define this object as text field delegate and selector for ending an editing session
	cellField.delegate = self;
	[cellField addTarget:self action:@selector(didPushKeyboardDone:) forControlEvents:UIControlEventEditingDidEndOnExit];

	return cell;
}


- (UITableViewCell *)standardViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row {

	// Common behaviour of tableview:cellForRowAtIndexPath
	static NSString *standardCellId = @"StandardCell";
	UITableViewCell *cell = [((ServerSubscriptionView *) self.view).table dequeueReusableCellWithIdentifier:standardCellId];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:standardCellId] autorelease];
		// In case of iPhone add the disclosure indicator in accessory view
		if (!DEVICE_IPAD)
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	// Define label for this cell
	NSMutableString *label = [[NSMutableString alloc] init];
	switch (section) {
		case 0:
			[label appendString:@"Adapter: "];
			break;
		case 1:
			[label appendString:@"Item: "];
			break;
		case 2:
			[label appendString:@"Schema: "];
			break;
		default: {
			NSString *tmp = [[NSString alloc] initWithFormat:@"Mode: %@", [_modeValues objectAtIndex:[_server.mode unsignedIntValue]]];
			[label appendString:tmp];
			[tmp release];
		}
	}
	
	if (section < 3)
		[label appendString:[_doubleFields objectAtIndex:(section * 2 + row)]];
	
	// Define label for any row
	cell.textLabel.text = label;
	[label release];
	return cell;
}


- (void) reduceTableViewHeigth {
	
	// Resize the table view frame to the visible are, applying the specular scratch animation of the keyboard
	CGRect frame = self.view.frame;
	frame.size.height -= ((DetailSelectionView *) _detailSelection.view).container.frame.size.height;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	
	self.view.frame = frame;
	
	[UIView commitAnimations];
}


- (void) restoreTableViewHeight {
	
	// Resize the table view frame to the visible are, applying the specular scratch animation of the keyboard
	CGRect frame;
	if ((_orientation == UIDeviceOrientationLandscapeLeft) || 
		(_orientation == UIDeviceOrientationLandscapeRight))
		frame = CGRectMake(0, 0, 480, 270);
	else
		frame = CGRectMake(0, 0, 320, 420);
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	
	self.view.frame = frame;
	
	[UIView commitAnimations];
}


- (void) showSelectedIndexPathOnTop {
	
	[((ServerSubscriptionView *) self.view).table scrollToRowAtIndexPath:_activeIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


- (UIView *) viewToShowOnEmptyServerList {
	
	// Create a UILabel with clear background in the middle of the detail view of the split view.
	// The text of the label is "No server available"
	UILabel *emptyServerList = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 150.0f, 400.0f, 50.0f)];
	emptyServerList.text = @"No server available";
	emptyServerList.backgroundColor = [UIColor clearColor];
	emptyServerList.textColor = [UIColor lightGrayColor];
	UIFont *font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:32.0f];
	emptyServerList.font = font;
	// Recorgnize this view by tag 1212
	emptyServerList.tag = 1212;
	return [emptyServerList autorelease];
}


#pragma mark Text and Subject of mail

- (NSString *) emailSubject {
	
	return [NSString stringWithFormat:@"Lightstreamer Explorer: Subscription configuration of server ", _server.name];
}


- (NSString *) emailBody {
	
	// Server configuaration section
	NSMutableString *body = [NSMutableString stringWithFormat:@"*** Server %@ configuration *** \n\n", _server.name];
	
	if ([self stringContainAValue:_server.address])
		[body appendFormat:@"Address: %@\n\n", _server.address];
	
	if ([self stringContainAValue:_server.user])
		[body appendFormat:@"User: %@\n", _server.user];							 
	
	if ([self stringContainAValue:_server.password])
		[body appendFormat:@"Password: %@\n\n", _server.password];							 
	
	if ([self stringContainAValue:_server.adapterSet])
		[body appendFormat:@"Adapter set: %@\n", _server.adapterSet];
	
	if ([_server.adapters count] != 0) {
		[body appendString:@"\nAdapters:\n"];
		for (AdapterInfo *adapter in _server.adapters)
			[body appendFormat:@"    %@\n", adapter.name];
	}
	
	if ([_server.items count] != 0) {
		[body appendString:@"\nItems:\n"];
		for (ItemInfo *item in _server.items)
			[body appendFormat:@"    %@\n", item.name];
	}
	
	if ([_server.fields count] != 0) {
		[body appendString:@"\nFields:\n"];
		for (FieldInfo *field in _server.fields)
			[body appendFormat:@"    %@\n", field.name];
	}
	
	
	//Server subscription section
	[body appendFormat:@"\n\n*** Server %@ subscription ***\n\n", _server.name];
	
	if ([self stringContainAValue:_server.adapter])
		[body appendFormat:@"Adapter: %@\n\n", _server.adapter];
	
	if ([self stringContainAValue:_server.group])
		[body appendFormat:@"Item: %@\n\n", _server.group];
	
	if ([self stringContainAValue:_server.schema])
		[body appendFormat:@"Schema: %@\n\n", _server.schema];
	
	if ([self stringContainAValue:_server.selector])
		[body appendFormat:@"Selector: %@\n", _server.selector];
	
	if (_server.mode)
		[body appendFormat:@"Mode: %@\n", [_modeValues objectAtIndex:[_server.mode unsignedIntValue]]];
	
	if (_server.bufferSize)
		[body appendFormat:@"Buffer size: %@\n", _server.bufferSize];
	
	if (_server.maxFrequency)
		[body appendFormat:@"Max frequency: %@\n", _server.maxFrequency];
	
	return body;
}


- (BOOL) stringContainAValue:(NSString *)string {
	
	if (string && ([string length] != 0))
		return YES;
	return NO;
}


#pragma mark -
#pragma mark Other initialization methods

- (void) defineDoubleFields {
	
	// Clear the _doubleFields variable and define two by two its value
	[_doubleFields removeAllObjects];
	[self defineDoubleFieldForSet:_server.adapters andValue:_server.adapter];
	[self defineDoubleFieldForSet:_server.items andValue:_server.group];
	[self defineDoubleFieldForSet:_server.fields andValue:_server.schema];
}


- (void) defineDoubleFieldForSet:(NSSet *)set andValue:(NSString *)value {
	
	// If the value parameter is contained in the name property of the values of the set parameter than fill the first value
	// else fill the second value
	NSUInteger startIndex = [_doubleFields count];
	[_doubleFields addObject:[NSString string]];
	if ([self set:set containsValue:value])
		[_doubleFields insertObject:value atIndex:startIndex];
	else {
		if (!value)
			value = [NSString string];
		[_doubleFields addObject:value];
	}
}


- (BOOL) set:(NSSet *)set containsValue:(NSString *)value {
	
	// Verify if the value parameter is contained in the name property of the values of the set parameter
	NSString *property = @"name";
	for (NSManagedObject *obj in set)
		if ([[obj valueForKey:property] isEqual:value])
			return YES;
	return NO;
}


#pragma mark -
#pragma mark Properties

@synthesize popOverController = _popOverController;
@synthesize selectedValue = _selectedValue;
@synthesize server = _server;

- (void) setServer:(ServerConfig *)server {
	
	// Assign the new server value
	@synchronized(_server) {
		[_server release];
		_server = [server retain];
	}
	
	// Define values of double fields
	[self defineDoubleFields];
	
	// If server is nil it is necessary to show the empty server list label,
	// else it is necessary remove that label, if is there, and reload the table with the new values
	// In case there is a server to show than the action button must be enabled, the label added and reload the table
	UITableView *table = ((ServerSubscriptionView *) self.view).table;
	if (_server) {
		UIView *emptyServerList = [self.view viewWithTag:1212];
		[emptyServerList removeFromSuperview];
		
		((ServerSubscriptionView *) self.view).footerView.hidden = NO;
		[table reloadData];
		
		self.title = _server.name;
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	else {
		[self.view addSubview:[self viewToShowOnEmptyServerList]];
		
		((ServerSubscriptionView *) self.view).footerView.hidden = YES;
		[table reloadData];
		
		self.title = @"Server list is empty";
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
	
	// In iPad portrait orientation it is necessary dismiss the popover
	if (_popOverController)
		[_popOverController dismissPopoverAnimated:YES];
}

@end
