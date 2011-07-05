//
//  CityPadDashboardViewController.m
//  CityPad
//
//  Created by Adam Wright on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityPadDashboardViewController.h"

@implementation CityPadDashboardViewController

@synthesize client;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    CIAPIGetClientAndTradingAccountRequest *infoRequest = [[[CIAPIGetClientAndTradingAccountRequest alloc] init] autorelease];
    
    [client makeRequest:infoRequest successBlock:^(CIAPIRequestToken *request, CIAPIAccountInformationResponse *response) {
        NSLog(@"Got some stuff - %i trading accounts", [response.TradingAccounts count]);
    } failureBlock:^(CIAPIRequestToken *request, id response) {
        
    } error:nil];
}

@end
