//
//  CityPadViewController.m
//  CityPad
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


#import "CityPadMasterViewController.h"

@implementation CityPadMasterViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if (currentView == DashboardView)
        [dashboardController didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    authenticator = [[CIAPIAuthenticator alloc] initWithDelegate:self];
    
    loggingInContainer.hidden = YES;
    loggingInContainer.frame = loginControlsContainer.frame;
    
    dashboardController = [[CityPadDashboardViewController alloc] initWithNibName:@"CityPadDashboardViewController" bundle:nil];
    
    //dashboardController.view.frame = self.view.frame;
    
    currentView = LoginView;
}

- (void)viewDidUnload
{
    [password release];
    password = nil;
    [loginButton release];
    loginButton = nil;
    [loginControlsContainer release];
    loginControlsContainer = nil;
    [loggingInContainer release];
    loggingInContainer = nil;
    
    [dashboardController release];
    
    [loginView release];
    loginView = nil;

    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (currentView == DashboardView)
        [dashboardController viewWillAppear:animated];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (currentView == DashboardView)
        [dashboardController viewDidAppear:animated];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (currentView == DashboardView)
        [dashboardController viewWillDisappear:animated];
    
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (currentView == DashboardView)
        [dashboardController viewDidDisappear:animated];
    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (currentView == DashboardView)
        return [dashboardController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [userName release];
    [password release];
    [password release];
    [loginButton release];
    [loginControlsContainer release];
    [loggingInContainer release];
    [loginView release];
    [super dealloc];
}

- (IBAction)loginPressed:(id)sender
{
    // Animate out the login controls, replacing them with the progress controller
    loggingInContainer.hidden = NO;
    [UIView transitionFromView:loginControlsContainer toView:loggingInContainer duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        
        [authenticator authenticateWithUserName:userName.text password:password.text];
    }];
}

- (void)authenticationSucceeded:(CIAPIAuthenticator*)authenticator client:(CIAPIClient*)client
{
    [userName resignFirstResponder];
    [password resignFirstResponder];
    
    // Do we need this? Seems the adding of a view from a controller might do it?
    [dashboardController viewWillAppear:YES];
    dashboardController.client = client;
    
    dashboardController.view.frame = CGRectMake(dashboardController.view.frame.origin.x + dashboardController.view.frame.size.width, dashboardController.view.frame.origin.y, dashboardController.view.frame.size.width, dashboardController.view.frame.size.height);
    
    [self.view addSubview:dashboardController.view];
    
    NSLog(@"Rect %@", NSStringFromCGRect(dashboardController.view.frame));

    [UIView transitionWithView:dashboardController.view duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{        
        dashboardController.view.frame = CGRectMake(dashboardController.view.frame.origin.x - dashboardController.view.frame.size.width,
                                                    dashboardController.view.frame.origin.y,
                                                    dashboardController.view.frame.size.width,
                                                    dashboardController.view.frame.size.height);
        
        loginView.frame = CGRectMake(loginView.frame.origin.x - loginView.frame.size.width, loginView.frame.origin.y,
                                    loginView.frame.size.width, loginView.frame.size.height);
    } completion:^(BOOL finished) {
        currentView = DashboardView;
        [loginView removeFromSuperview];
    }];
}

- (void)authenticationFailed:(CIAPIAuthenticator*)authenticator error:(NSError*)error
{
    [userName resignFirstResponder];    
    [password resignFirstResponder];
    
    [UIView transitionFromView:loggingInContainer toView:loginControlsContainer duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        [[[UIAlertView alloc] initWithTitle:@"Login error" message:@"Login failed. Check your username and password" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
    }];
}

@end
