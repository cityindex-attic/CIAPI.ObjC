//
//  AppDelegate_iPad.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"


@interface AppDelegate_iPad : AppDelegate_Shared {
	
@private
	UINavigationController *_masterNavController;
	UINavigationController *_detailNavController;
	UISplitViewController *_splitController;
}

#pragma mark -
#pragma mark Utility methods

// Store last shown server in user defaults
- (void) storeLastShownServer;


#pragma mark -
#pragma mark Properties

// The master navigation controller instance
@property (nonatomic, readonly) UINavigationController *masterNavController;

// The detail navigation controller instance
@property (nonatomic, readonly) UINavigationController *detailNavController;

@end

