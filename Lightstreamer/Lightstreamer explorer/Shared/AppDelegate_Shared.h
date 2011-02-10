//
//  AppDelegate_Shared.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate_Shared : NSObject <UIApplicationDelegate> {

	// The unique used window instance
    UIWindow *_window;
    
@private
	// CoreData management variables
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Core Data support

// Initialize the context and the Core Data management. Multiple call to this method does not generate issues
- (void) initContext;

// Store context pending changes in a persisten way
- (void) saveContext;

// Discard any context pending change and restore any value to the last stored one
- (void) rollbackContext;

#pragma mark -
#pragma mark General utilities

// Return document folder path of this application
- (NSString *) applicationDocumentsDirectory;

#pragma mark -
#pragma mark Properties

// The unique window instance of the application
@property (nonatomic, retain, readonly) IBOutlet UIWindow *window;

// The unique Core Data context used by this application
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

// The Core Data schema descriptor of the objets used by this application
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;

// The Core Data mediator between the persistent store and the context
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

