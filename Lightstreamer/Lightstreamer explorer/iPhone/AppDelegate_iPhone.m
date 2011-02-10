//
//  AppDelegate_iPhone.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "ServerListViewController.h"


@implementation AppDelegate_iPhone


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) init {
	
	self = [super init];
	if (self)
		_navController = nil;
	
	return self;
}


- (void) dealloc {
	
	[_navController release];	
    [super dealloc];
}


#pragma mark -
#pragma mark Methods of UIApplicationDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Send the same message on super in order to initialize the contexts
	[super application:application didFinishLaunchingWithOptions:launchOptions];
	
	// When the application start the list of recorded server is the root controller of the navigation controller
	ServerListViewController *serverList = [[ServerListViewController alloc] init];
	_navController= [[UINavigationController alloc] initWithRootViewController:serverList];
	[serverList release];
	
	// Adding the nav controller to the window and making it visible
	[_window addSubview:_navController.view];
	[_window makeKeyAndVisible];
		
    return YES;
}


#pragma mark -
#pragma mark Properties

@synthesize navController= _navController;


@end

