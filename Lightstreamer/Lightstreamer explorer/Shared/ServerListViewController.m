//
//  ServerListViewController.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerListViewController.h"
#import "ServerListView.h"
#import "ServerDetailsViewController.h"
#import "ServerConfig.h"
#import "AppDelegate_Shared.h"
#import "AppDelegate_iPad.h"
#import "ServerSubscriptionViewController.h"


@implementation ServerListViewController

@synthesize selectedRow = _selectedRow;

#pragma mark -
#pragma mark Initialization

- (id)init {
	
	self = [super init];
	if (self) {
		_selectedRow = nil;
		_fetchedResultsController = nil;

		// Set the title page of the navigation controller
		self.title = @"Servers";
		
		// Become observer of persistent save operations on the context
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged) name:NSManagedObjectContextDidSaveNotification object:SHARED_APP_DELEGATE.managedObjectContext];
	}
	return self;
}


- (void)dealloc {
	
	// Remove any kind of observation
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[_fetchedResultsController release];
	[_selectedRow release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {
	
	// Load view from nib file
	ServerListView *serverListView = [[[NSBundle mainBundle] loadNibNamed:@"ServerListView" owner:self options:nil] lastObject];
	self.view = serverListView;
	
	// Set this view controller as table's delegate and data source	
	serverListView.table.dataSource = self;
	serverListView.table.delegate = self;
	
	// Add plus button on the navigation bar
	UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addServer)];
	self.navigationItem.rightBarButtonItem = plusButton;
	[plusButton release];
	
	// Perfoem fetch in case it has not been done
	if (!_fetchedResultsController)
		[self performFetch];	
}


-(void) viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	// On iPad application it is necessary select the row matching the name of the server
	if (DEVICE_IPAD)
		[((ServerListView *) self.view).table selectRowAtIndexPath:_selectedRow animated:NO scrollPosition:UITableViewScrollPositionNone];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	// Application can rotate in any direction
	return YES;
}


#pragma mark -
#pragma mark Methods of UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

	// Return the number of sections. In this case there is only one
	return [[_fetchedResultsController sections] count];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	// Number of element of the passed section.
    return [[[_fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Any cell has a default style, with a simple label and a disclosure button
	static NSString *cellIdentifier = @"ServerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    
	// Define label text with the name of the server at the same position
    ServerConfig *server = [_fetchedResultsController objectAtIndexPath:indexPath];	
	cell.textLabel.text = server.name;
    return cell;
}


#pragma mark -
#pragma mark Methods of UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Keep trace of the selected row. In iPad case, if the view disappear and than re-apper we are able to show the selected row
	_selectedRow = indexPath;
	
	// Define the selected server
	ServerConfig *server = [_fetchedResultsController objectAtIndexPath:indexPath];
	
	// The view to show in case of this kind of selection is the server subscription view
	// In case of iPad, if the detail view of the split view is already the server subscription it is enough update the server shown
	BOOL showOnIPad = DEVICE_IPAD;
	if (showOnIPad) {
		UIViewController <LSExpPopoverManagement> *topViewController = [IPAD_APP_DELEGATE.detailNavController topViewController];
		if ([topViewController isKindOfClass:[ServerSubscriptionViewController class]]) {
			topViewController.server = server;
			return;
		}
	}
	
	// Here in case of iPhone or if the view has to be changed on iPad
	ServerSubscriptionViewController *serverSubscription = [[ServerSubscriptionViewController alloc] init];
	if (showOnIPad)
		// Show on detail view of the split view the server subscription
		[self showOnIPadDetailViewThisViewControler:serverSubscription];
	else
		// Push on navigation controller the server subscription controller
		[self.navigationController pushViewController:serverSubscription animated:TRUE];
	
	serverSubscription.server = server;	
	[serverSubscription release];
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	// Define the server of the disclosure button tapped
	ServerConfig *server = [_fetchedResultsController objectAtIndexPath:indexPath];
	
	[self showServerDetailsViewOfServer:server];	
}


#pragma mark -
#pragma mark Methods related to Code Data

-(void)performFetch {

	NSManagedObjectContext *context = [SHARED_APP_DELEGATE managedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ServerConfig" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:100];
	
	// Apply an ascending sort for the items
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	[sortDescriptor release];
	[fetchRequest setSortDescriptors:descriptors];
	
	// Init the fetched results controller
	NSError *error;
	_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"ServerList"];
	_fetchedResultsController.delegate = self;
	if (![_fetchedResultsController performFetch:&error])
		NSLog(@"Error: %@", [error localizedDescription]);
	[fetchRequest release];
}


#pragma mark -
#pragma mark Internal Methods

-(void) addServer {
	
	[self showServerDetailsViewOfServer:nil];
}


- (void) showServerDetailsViewOfServer:(ServerConfig *)server {
	
	// In this case we not keep trace of the selected row because the disclosure button has been tapped.
	// In case a row is alredy selected it is necessary clean the selection
	if (_selectedRow) {
		[((ServerListView *) self.view).table deselectRowAtIndexPath:_selectedRow animated:YES];
		_selectedRow = nil;
	}
	
	// The view to show in case of this kind of selection is the server details view
	// In case of iPad, if the detail view of the split view is already the server details it is enough update the server shown
	BOOL showOnIPad = DEVICE_IPAD;
	if (showOnIPad) {
		UIViewController <LSExpPopoverManagement> *topViewController = [IPAD_APP_DELEGATE.detailNavController topViewController];
		if ([topViewController isKindOfClass:[ServerDetailsViewController class]]) {
			topViewController.server = server;
			return;
		}
	}
	
	// Here in case of iPhone or if the view has to be changed on iPad
	ServerDetailsViewController *serverDetails = [[ServerDetailsViewController alloc] init];
	serverDetails.server = server;
	if (showOnIPad)
		// Show on detail view of the split view the server details
		[self showOnIPadDetailViewThisViewControler:serverDetails];
	else
		// push on navigation controller the server details controller
		[self.navigationController pushViewController:serverDetails animated:TRUE];
	
	[serverDetails release];
}	


- (void) showOnIPadDetailViewThisViewControler:(UIViewController <LSExpPopoverManagement, UISplitViewControllerDelegate> *)toShow {
	
	// Passed LSExpPopoverManagement must be the new popover controller.
	UIViewController <LSExpPopoverManagement> *parentShownController = [IPAD_APP_DELEGATE.detailNavController.viewControllers objectAtIndex:0];
	toShow.popOverController = parentShownController.popOverController;
	// It is necessary put popOverController of the previous detail controller to nil because this view controller could be released not immediatly, but it 
	// does not have to responde to popover interaction.
	parentShownController.popOverController = nil; 
	
	// Bring the left button of the navigation bar of the old view to the new view.
	// If the old view does not show this button than it will not be shown on the new view
	UIBarButtonItem *leftButton = parentShownController.navigationItem.leftBarButtonItem;
	[toShow.navigationItem setLeftBarButtonItem:leftButton animated:YES];
	
	// Show the new view
	NSArray *viewControllers = [[NSArray alloc] initWithObjects:toShow, nil];
	[parentShownController.navigationController setViewControllers:viewControllers animated:NO];
	[viewControllers release];
	
	// The new split view controller delegate is the view controller to show
	self.splitViewController.delegate = toShow;
}


- (void) contextChanged {
	
	// Reload the table view data
	[self performFetch];
	NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:0];
	[((ServerListView *) self.view).table reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
	[sections release];
}


#pragma mark -
#pragma mark Properties

- (NSFetchedResultsController *) fetchedResultsController {
	
	if (! _fetchedResultsController)
		[self performFetch];
	
	return _fetchedResultsController;
}

@end
