//
//  AppDelegate_iPhone.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"


@class ServerListViewController;

@interface AppDelegate_iPhone : AppDelegate_Shared {
	
@private
	UINavigationController *_navController;
}


#pragma mark -
#pragma mark Properties

// The navigation controller instance
@property (nonatomic, readonly) UINavigationController *navController;


@end

