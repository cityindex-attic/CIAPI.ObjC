//
//  CityPadViewController.h
//  CityPad
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CIAPI.h"

#import "CityPadDashboardViewController.h"

enum CurrentView
{
    LoginView,
    DashboardView
};

@interface CityPadMasterViewController : UIViewController<CIAPIAuthenticatorDelegate> {
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
    IBOutlet UIButton *loginButton;
    IBOutlet UIView *loginControlsContainer;
    IBOutlet UIView *loggingInContainer;
    IBOutlet UIView *loginView;
    
    @private
    CIAPIAuthenticator *authenticator;
    CityPadDashboardViewController *dashboardController;
    enum CurrentView currentView;
}

- (IBAction)loginPressed:(id)sender;

@end
