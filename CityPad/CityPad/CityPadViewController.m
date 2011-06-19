//
//  CityPadViewController.m
//  CityPad
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityPadViewController.h"

#import "CIAPI.h"

@implementation CityPadViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CIAPIAuthenticator *auth = [[CIAPIAuthenticator alloc] init];
    
    BOOL r = [auth authenticateWithUserNameSynchronously:@"DM189301" password:@"password" error:nil];
    
    if (r)
        [[[UIAlertView alloc] initWithTitle:@"Logged in OK" message:@"You are logged in" delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil] show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
