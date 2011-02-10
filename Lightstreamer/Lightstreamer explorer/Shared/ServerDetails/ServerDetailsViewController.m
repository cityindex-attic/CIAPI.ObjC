//
//  ServerDetailsViewController.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerDetailsViewController.h"
#import "ServerDetailsView.h"
#import "AppDelegate_Shared.h"
#import "ServerConfig.h"
#import "EditableCell.h"
#import "ServerSingleDetailViewController.h"
#import "ServerListViewController.h"
#import "Macros.h"


#define NAME_KEY @"name"
#define ADDRESS_KEY @"address"
#define USER_KEY @"user"
#define PWD_KEY @"password"
#define ADAPTERSET_KEY @"adapterSet"
#define ADAPTERS_KEY @"adapters"
#define FIELDS_KEY @"fields"
#define ITEMS_KEY @"itemsSet"

#define SERVER_ADDRESS_PREFIX @"http://"

#define NEW_SERVER_VIEW_TITLE @"New Server"


@implementation ServerDetailsViewController

#pragma mark -
#pragma mark Initialization and Deallocation


- (id) init {
	
	// Init defining group style of the table view
	self = [super init];
	if (self) {
		// Assign object attributes
		_server = nil;
		_tmpValues = [[NSMutableDictionary alloc] init];
		_changesApplied = NO;
		_exitingFromView = YES;
		_popOverController = nil;
		
		// Adding observer to the changes applaied property. A change on ServerSingleDetailViewController change also the value of this property.
		[self addObserver:self forKeyPath:@"changesApplied" options:0 context:NULL];
	}
	
	return self;	
}


- (void) dealloc {

	[self removeObserver:self forKeyPath:@"changesApplied"];
	[_server release];
	[_tmpValues release];
	[_popOverController release];
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {
	
	// Load view from nib file
	ServerDetailsView *serverDetailsView = [[[NSBundle mainBundle] loadNibNamed:@"ServerDetailsView" owner:self options:nil] lastObject];
	self.view = serverDetailsView;
	
	// Set this view controller as table's delegate and data source	
	serverDetailsView.table.dataSource = self;
	serverDetailsView.table.delegate = self;
	
	// Add save butron on the right side of the navigation bar. Left side has not a custom management, then the default behaviour will be assigned.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
}


- (void) viewWillAppear:(BOOL)animated {
	 
	// This function has been overriden because previous ti iOS 4.2 the selected row,
	// after a navigation on other views does not hide the selection. This is the target of next instructions
	UITableView *table = ((ServerDetailsView *) self.view).table;
	NSIndexPath* selection = [table indexPathForSelectedRow];
	if (selection)
		[table deselectRowAtIndexPath:selection animated:YES];
	
	
	[super viewWillAppear:animated];
}


- (void) viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	// Until a selectable cell wil be tapped, the view will disapper due to an exit from the view
	_exitingFromView = YES;
	
	// When view did appear the last section of the table should be reloaded.
	// That because in case of changes on server single detail view the text of these cells could change.
	NSIndexSet *sectionThree = [[NSIndexSet alloc] initWithIndex:3];
	[((ServerDetailsView *) self.view).table reloadSections:sectionThree withRowAnimation:UITableViewRowAnimationNone];
	[sectionThree release];
	
	// When iPad is in portrait, the detail view of split view was showing a server subscription view, and the user
	// tap a disclosure button on master view of split view, than _popOverController is not nil and the popover must be dismissed
	if (_popOverController)
		[_popOverController dismissPopoverAnimated:YES];
}


- (void) viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	// If remove this view from navigation stack, it is necessary discard any not saved change 
	if (_exitingFromView)
		[SHARED_APP_DELEGATE rollbackContext];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	// This view can rotate in any direction
	return YES;
}


#pragma mark -
#pragma mark Methods of UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	
    // There are four sections
	return 4;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	// The first two sections have two cells, the third only one cell and the last section contains three cells
	switch (section) {
		case 2:
			return 1;
		case 3:
			return 3;
	}
	
	return 2;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	// The first three sections contain EditableCells, the last section contains default cells
	if (indexPath.section == 3)
		return [self standardViewCellWithSection:indexPath.section andRow:indexPath.row];
	return [self editableViewCellWithSection:indexPath.section andRow:indexPath.row];
}


#pragma mark -
#pragma mark Methods of UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Editable cell are not selectables. On iPad the unselectable cells have a bit different background color
	if (indexPath.section < 3)
		return nil;
	
	return indexPath;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// The target of this function is to push on navigation a server single detail view
	
	// Resign keyboard in case of editing of a text view
	if (_activeField)
		[_activeField resignFirstResponder];
	
	// View will disappear but will not be removed from the navigation stack
	_exitingFromView = NO;
	
	// It is necessary give to the new view controller a real instance of server. 
	// If server is not available, on plus tap in server list view, it must be created
	if (! _server) {
		NSManagedObjectContext *context = [SHARED_APP_DELEGATE managedObjectContext];
		_server = [[NSEntityDescription insertNewObjectForEntityForName:@"ServerConfig" inManagedObjectContext:context] retain];
	}	
	
	// Creating a SingleDetail object which contains every information that the new view needs
	NSString *valuesClassName;
	NSString *valuesName;
	NSString *propertyName;
	SEL addValuesMethod;
	SEL removeValueMethod;
	switch (indexPath.row) {
		case 0:
			valuesClassName = @"AdapterInfo";
			valuesName = @"Adapters";
			propertyName = @"adapters";
			addValuesMethod = @selector(addAdapters:);
			removeValueMethod = @selector(removeAdaptersObject:);
			break;
		case 1:
			valuesClassName = @"ItemInfo";
			valuesName = @"Items";
			propertyName = @"items";
			addValuesMethod = @selector(addItems:);
			removeValueMethod = @selector(removeItemsObject:);
			break;			
		default:
			valuesClassName = @"FieldInfo";
			valuesName = @"Fields";
			propertyName = @"fields";
			addValuesMethod = @selector(addFields:);
			removeValueMethod = @selector(removeFieldsObject:);
			break;
	}
	
	SingleDetail *singleDetail = [[SingleDetail alloc] init];
	singleDetail.server = _server;
	singleDetail.valuesClassName = valuesClassName;
	singleDetail.valuesName = valuesName;
	singleDetail.propertyName = propertyName;
	singleDetail.addValuesSelector = addValuesMethod;
	singleDetail.removeValueSelector = removeValueMethod;
	singleDetail.previousViewController = self;	
	ServerSingleDetailViewController *singleDetailVC = [[ServerSingleDetailViewController alloc] initWithDetail:singleDetail];
	[singleDetail release];

	// Pushing the new view controller into the navigation controller
	[self.navigationController pushViewController:singleDetailVC animated:YES];
	[singleDetailVC release];
}


#pragma mark -
#pragma mark Methods of UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	[super textFieldDidBeginEditing:textField];
	
	// If the text field did begin to edit is the address one and it is an empty text, the string of macro  is automatically added
	if (textField.tag == 102) {
		NSString *text = textField.text;
		if (!text || ([text length] == 0))
			textField.text = SERVER_ADDRESS_PREFIX;
	}
}


-  (void) textFieldDidEndEditing:(UITextField *)textField {
	
	[super textFieldDidEndEditing:textField];
	
	// Trim text of the text field
	textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	// Recognize the edited field
	NSString *key;
	switch (textField.tag) {
		case 101:
			key = NAME_KEY;
			break;
		case 102:
			key = ADDRESS_KEY;
			if ([textField.text isEqual:SERVER_ADDRESS_PREFIX])
				textField.text = nil;
			break;
		case 103:
			key = USER_KEY;
			break;
		case 104:
			key = PWD_KEY;
			break;
		default:
			key = ADAPTERSET_KEY;
	}

	// Verify if the value inserted has changed
	NSString *previousValue = [_tmpValues valueForKey:key];
	if ((previousValue == textField.text) || ([previousValue isEqual:textField.text]))
		return;
	
	// Store in memory the temporary inserted value
	[_tmpValues setValue:textField.text forKey:key];

	// If is the the only change on server details than change the value of the property changesApplied
	if (!_changesApplied) 
		self.changesApplied = YES;
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
#pragma mark Method of NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	
	// This function is called any time the application set the value of appliedChanges property.
	// In risponse to this event the only behaviour is to enable the save button
	self.navigationItem.rightBarButtonItem.enabled = YES;
}


#pragma mark -
#pragma mark Internal methods

-(void) save {
	
	// If save button has been pressed while the user was editing a text field it is necessary resign the keybord.
	// Doing that also the text just edited will be saved in memory storage and available for the next on storage save operation.
	if (_activeField)
		[_activeField resignFirstResponder];
	
	// Verify that the server name is not an empty text. If case it is empty, an allert view will be shown in order to notify the user of that unaccepted case.
	NSString *name = [_tmpValues valueForKey:@"name"];
	if (!name || ([name length] == 0)) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Server name is missing" message:@"Cannot save server without name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
	}
	
	// If server is not available it must be created
	if (! _server) {
		NSManagedObjectContext *context = [SHARED_APP_DELEGATE managedObjectContext];
		_server = [[NSEntityDescription insertNewObjectForEntityForName:@"ServerConfig" inManagedObjectContext:context] retain];
	}	
	
	// Check if the server name is changed.
	BOOL nameHasChanged = YES;
	if ([name compare:_server.name] == NSOrderedSame)
		nameHasChanged = NO;
	
	// Copy the on memory value to the persistent object and persist these changes
	_server.name = name;
	_server.address = [_tmpValues valueForKey:ADDRESS_KEY];
	_server.user = [_tmpValues valueForKey:USER_KEY];
	_server.password = [_tmpValues valueForKey:PWD_KEY];
	_server.adapterSet = [_tmpValues valueForKey:ADAPTERSET_KEY];
	[SHARED_APP_DELEGATE saveContext];
	
	// if the server name is changed, set the title view to the new server name
	if (nameHasChanged)
		self.title = name;
	
	// Disable save button
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	// Change the value of changesApplied property
	_changesApplied = NO;
}


-(UITableViewCell *) editableViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row {
	
	// At the first time we are not able to define cell identifier of a custom created cell.
	// Default behaviour is the name of the UITableViewCell, but in order to be sure the identifier will be set at the first nib load
	static NSString *cellIdentifier = nil;
	
	// Common behaviour of tableview:cellForRowAtIndexPath
	EditableCell *cell = (EditableCell *) [((ServerDetailsView *) self.view).table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
		// Load custom created UITableViewCell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditableCell" owner:self options:nil] lastObject];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		// At the first load the cellIdentifier is set
		if (!cellIdentifier)
			cellIdentifier = [cell.reuseIdentifier retain];
	}
    
	// Define specific detail of any different editable row
	UITextField *cellField = cell.cellField;
	// Disable autocapitalization by default
	UITextAutocapitalizationType autocapitalizationType = UITextAutocapitalizationTypeNone;
	// Secure text disabled by default;
	BOOL secureText = NO;
	// Default keyboard type by default
	UIKeyboardType keyboardType = UIKeyboardTypeDefault;
	
	NSString *label;
	NSString *text;
	NSUInteger fieldTag;
	if (section == 0) {
		if (row == 0) {
			label = @"Name";
			text = [_tmpValues valueForKey:NAME_KEY];
			fieldTag = 101;
			// The only case of autocapitalization
			autocapitalizationType = UITextAutocapitalizationTypeSentences;
		}
		else {
			label = @"Address";
			text = [_tmpValues valueForKey:ADDRESS_KEY];
			fieldTag = 102;
			// Change keyboard type to an optimized one for URL entry
			keyboardType = UIKeyboardTypeURL;
		}
	}
	else if (section == 1){
		if (row == 0) {
			label = @"User";
			text = [_tmpValues valueForKey:USER_KEY];
			fieldTag = 103;
		}
		else {
			label = @"Password";
			text = [_tmpValues valueForKey:PWD_KEY];
			fieldTag = 104;
			// Hide text value of this field enabling secure text value
			secureText = YES;
		}
	}
	else {
		label = @"Adapter set";
		text = [_tmpValues valueForKey:ADAPTERSET_KEY];
		fieldTag = 105;
	}
	
	cell.cellLabel.text = label;
	cellField.text = text;
	cellField.tag = fieldTag;
	cellField.autocapitalizationType = autocapitalizationType;
	cellField.secureTextEntry = secureText;
	cellField.keyboardType = keyboardType;
	
	//Disable autocorrection of inserted text
	cellField.autocorrectionType = UITextAutocorrectionTypeNo;
	
	// Define this object as text field delegate and selector for ending an editing session
	cellField.delegate = self;
	[cellField addTarget:self action:@selector(didPushKeyboardDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	return cell;
}


-(UITableViewCell *) standardViewCellWithSection:(NSUInteger)section andRow:(NSUInteger)row {
	
	// Common behaviour of tableview:cellForRowAtIndexPath
	static NSString *standardCellId = @"StandardCell";
	UITableViewCell *cell = [((ServerDetailsView *) self.view).table dequeueReusableCellWithIdentifier:standardCellId];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:standardCellId] autorelease];
		// Put disclosure indicator in accessory view
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	// Define text label with this pattern:
	//		<kind of detail>: #number of values of this detail#, in case exists at least a value
	//		<kind of detail>, in case not exists any value
	NSUInteger numberOfValues = 0;
	NSMutableString *label = [[NSMutableString alloc] init];
    switch (row) {
		case 0:
			[label appendString:@"Adapters" ];
			numberOfValues = [_server.adapters count];
			if (numberOfValues != 0)
				[label appendFormat:@": %d %@", numberOfValues, @"adapter"];
			break;
		case 1:
			[label appendString:@"Items"];
			numberOfValues = [_server.items count];
			if (numberOfValues != 0)
				[label appendFormat:@": %u %@", numberOfValues, @"item"];
			break;
		default:
			[label appendString:@"Schemas"];
			numberOfValues = [_server.fields count];
			if (numberOfValues != 0)
				[label appendFormat:@": %u %@", numberOfValues, @"schema"];
	}
	
	if (numberOfValues > 1)
		[label appendString:@"s"];
	
	// Define label for any row
	cell.textLabel.text = label;
	[label release];
	
    return cell;
}


#pragma mark -
#pragma mark Properties

@synthesize changesApplied = _changesApplied;
@synthesize popOverController = _popOverController;
@synthesize server = _server;

- (void) setServer:(ServerConfig *) server {
	
	// Discard any pending change, if exist, becuase the detail of a new server will be displayed
	if (_changesApplied)
		[SHARED_APP_DELEGATE rollbackContext];
	
	// Change the server reference
	@synchronized (_server) {
		
		[_server release];
		_server = [server retain];
	}
	
	// Load on temporary dictionary the details of the server
	[_tmpValues removeAllObjects];
	[_tmpValues setValue:_server.name forKey:NAME_KEY];
	[_tmpValues setValue:_server.address forKey:ADDRESS_KEY];
	[_tmpValues setValue:_server.user forKey:USER_KEY];
	[_tmpValues setValue:_server.password forKey:PWD_KEY];
	[_tmpValues setValue:_server.adapterSet forKey:ADAPTERSET_KEY];		
	[((ServerDetailsView *) self.view).table reloadData];
	
	// If the new server is nil, the view title is the macro NEW_SERVER_VIEW_TITLE and the save button must be enable,
	// else the view title is the server name and the save button must be disabled
	if (! _server) {
		self.title = NEW_SERVER_VIEW_TITLE;
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	else {
		self.title = _server.name;
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}

	// When iPad is in portrait and the user tap on disclosure button, than _popOverController is not nil and the popover must be dismissed
	if (_popOverController)
		[_popOverController dismissPopoverAnimated:YES];
}

@end
