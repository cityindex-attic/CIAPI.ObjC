//
//  AppDelegate_iPad.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "ServerListViewController.h"
#import "ServerSubscriptionViewController.h"
#import "LSExpPopoverManagement.h"


#define LAST_SERVER_SHOWN_KEY @"last_server_shown_key" 

@implementation AppDelegate_iPad


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) init {
	
	self = [super init];
	if (self) {
		_masterNavController = nil;
		_detailNavController = nil;
		_splitController = nil;
	}
	
	return self;
}


- (void) dealloc {
	
	[_masterNavController release];
	[_detailNavController release];
	[_splitController release];
    [super dealloc];
}


#pragma mark -
#pragma mark Methods of UIApplicationDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Send the same message on super in order to initialize the contexts
	[super application:application didFinishLaunchingWithOptions:launchOptions];
	
	// Obtaining instance of user default and retry on it the UUID of the last shown server, if exist
	ServerConfig *server = nil;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *serverID_string = [userDefaults objectForKey:LAST_SERVER_SHOWN_KEY];
	
	// If exist a previously shown server try to get it from the context. If it exist from the context server will point
	// to the right instance else will be nil
	if (serverID_string) {
		NSURL *serverID_URL = [[NSURL alloc] initWithString:serverID_string];
		NSManagedObjectID *serverID = [self.persistentStoreCoordinator managedObjectIDForURIRepresentation:serverID_URL]; 
		server = (ServerConfig *) [self.managedObjectContext existingObjectWithID:serverID error:nil];
		[serverID_URL release];
	}
	
	// Initialize the server list view controller in order to obtain the server list.
	ServerListViewController *serverList = [[ServerListViewController alloc] init];
	
	// If server exist than it must be selected in the master view and its details must be shown in the detail view
	// If server does not exist try to show the first server in the server list. If server list does not has items
	// no row will be seleceted and detail view will not show any server detail
	NSIndexPath *rowToSelect = nil;;
	if (server)
		rowToSelect = [serverList.fetchedResultsController indexPathForObject:server];
	else 
		if ([serverList tableView:serverList.tableView numberOfRowsInSection:0] > 0) {
			rowToSelect = [NSIndexPath indexPathForRow:0 inSection:0];
			server = [serverList.fetchedResultsController objectAtIndexPath:rowToSelect];
		}

	// Initilize the main othe view controllers. At the start up the detail controller is a server subscription view controller.
	// Detail view is initialized with the retrieved server instance
	ServerSubscriptionViewController *serverSubscription = [[ServerSubscriptionViewController alloc] init];
	serverSubscription.server = server;
	_splitController = [[UISplitViewController alloc] init];

	_masterNavController = [[UINavigationController alloc] initWithRootViewController:serverList];
	_detailNavController = [[UINavigationController alloc] initWithRootViewController:serverSubscription];

	// Define the detail nav controller as split view controller delegate and set the view controllers
	_splitController.delegate = serverSubscription;
	[_splitController setViewControllers:[NSArray arrayWithObjects:_masterNavController, _detailNavController, nil]];
	
	// Select the table row corresponding to the retrieved server instance.
	serverList.selectedRow = rowToSelect;
	
	// Adding the split controller to the window and making it visible
	[_window addSubview:_splitController.view];
    [_window makeKeyAndVisible];
	
	[serverList release];
	[serverSubscription release];
	
    return YES;
}


- (void) applicationWillTerminate:(UIApplication *)application {
	
	// Save last shown server and terminate
	[self storeLastShownServer];
	[super applicationWillTerminate:application];
}


- (void) applicationDidEnterBackground:(UIApplication *)application {
	
	// Save last shown server and terminate
	[self storeLastShownServer];
	[super applicationDidEnterBackground:application];
}


- (void) storeLastShownServer {
	
	// Save on user defaults the UUID of the shown server
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	ServerConfig *server = ((id <LSExpPopoverManagement>) [[_detailNavController viewControllers] objectAtIndex:0]).server;
	NSURL *serverId_URL = [[server objectID] URIRepresentation];
	[userDefaults setObject:[serverId_URL absoluteString] forKey:LAST_SERVER_SHOWN_KEY];
	[userDefaults synchronize];
}


#pragma mark -
#pragma mark Properties

@synthesize masterNavController= _masterNavController;
@synthesize detailNavController= _detailNavController;

@end

