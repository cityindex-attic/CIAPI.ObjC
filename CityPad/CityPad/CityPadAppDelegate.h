//
//  CityPadAppDelegate.h
//  CityPad
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityPadViewController;

@interface CityPadAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CityPadViewController *viewController;

@end
