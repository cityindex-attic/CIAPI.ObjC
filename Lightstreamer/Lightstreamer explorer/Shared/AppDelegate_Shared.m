//
//  AppDelegate_Shared.m
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "AppDelegate_Shared.h"


@implementation AppDelegate_Shared


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) init {

	self = [super init];
	if (self) {
		_window = nil;
		
		_managedObjectContext = nil;
		_managedObjectModel = nil;
		_persistentStoreCoordinator = nil;
	}
	
	return self;
}

- (void) dealloc {
	
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    
    [_window release];

    [super dealloc];
}


#pragma mark -
#pragma mark Methods of UIApplicationDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	// Initialize Core Data unique context
	[self initContext];
	return YES;
}


- (void) applicationWillTerminate:(UIApplication *)application {

    // Save context pending changes
	[self saveContext];
}


- (void) applicationDidEnterBackground:(UIApplication *)application {

    // Save context pending changes
	[self saveContext];
}


#pragma mark -
#pragma mark Core Data support

- (NSString *)applicationDocumentsDirectory {
	
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


-(void) initContext {
	
	// In order to inizialize the context it is enough apply a save operation on the context
	[self saveContext];
}


- (void) saveContext {
	
	// Take instance of the context and, if has pending changes, try to store them in a persistent way
	NSManagedObjectContext *managedObjectContext= self.managedObjectContext;
    if (managedObjectContext) {
		
		NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
            NSLog(@"Error while saving context: %@, user info: %@", error, [error userInfo]);
    }
}    

- (void) rollbackContext {
	
	// Apply a rollback operation on the context only if the context has pending changes
	NSManagedObjectContext *managedObjectContext= self.managedObjectContext;
    if (managedObjectContext)
		if ([managedObjectContext hasChanges]) 
			[managedObjectContext rollback];
}


#pragma mark -
#pragma mark Properties

@synthesize window= _window;


- (NSManagedObjectContext *) managedObjectContext {
    
	// If the managed object context is alredy initialized than return its instance
    if (_managedObjectContext)
        return _managedObjectContext;

	// To initialize the managed object context it is necessary set the persistence store coordinator
    NSPersistentStoreCoordinator *coordinator= [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext= [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }

    return _managedObjectContext;
}


- (NSManagedObjectModel *) managedObjectModel {
    
	// If the managed object model is alredy initialized than return its instance
    if (_managedObjectModel)
        return _managedObjectModel;

	// To initialize the managed object model it is necessary set the database model file path
	NSURL *modelURL= [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Lightstreamer_explorer" ofType:@"momd"]];
    _managedObjectModel= [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    

    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    
	// If the persistent store coordinator is alredy initialized than return its instance
    if (_persistentStoreCoordinator)
        return _persistentStoreCoordinator;

	// To initialize the managed object model it is necessary set the manged object model
    _persistentStoreCoordinator= [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
	// Create an option dictionary for the persistent store coordinator. Options define:
	// - automatically attempt to migrate versioned stores
	// - attempt to create the mapping model automatically
	NSDictionary *options= [NSDictionary dictionaryWithObjectsAndKeys:
							[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
							[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, 
							nil];

	// Define the database store path. Database will be stored into the document directory with the defined name
    NSString *storeString= [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Lightstreamer_explorer.sqlite"];
	NSURL *storeURL = [NSURL fileURLWithPath:storeString];
	
	// Setting persistence store coordinator type to SQLLite database, specifing the defined location and setting its option
    NSError *error= nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
        NSLog(@"Error while adding persistent store: %@, user info: %@", error, [error userInfo]);

    return _persistentStoreCoordinator;
}


@end
