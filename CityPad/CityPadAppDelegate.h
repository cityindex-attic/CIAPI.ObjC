//
//  CityPadAppDelegate.h
//  CityPad
//
//  Created by Adam Wright on 27/01/2011.
//

#import <UIKit/UIKit.h>

@class CityPadViewController;

@interface CityPadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CityPadViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CityPadViewController *viewController;

@end

