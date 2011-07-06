//
//  CityPadDashboardViewController.m
//  CityPad
//
//  Created by Adam Wright on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityPadDashboardViewController.h"
#import "MarketListViewController.h"

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
    tradingAccountsPopover = [[TradingAccountListViewController alloc] initWithNibName:@"TradingAccountListViewController" bundle:nil];    
    
    [client makeRequest:infoRequest successBlock:^(CIAPIRequestToken *request, CIAPIAccountInformationResponse *response) {
        userNameLabel.text = response.LogonUserName;
        tradingInLabel.text = response.ClientAccountCurrency;
        tradingAccountInfo = [response retain];
    } failureBlock:^(CIAPIRequestToken *request, id response) {
        
    } error:nil];
}

- (void)dealloc {
    [userNameLabel release];
    [tradingInLabel release];
    
    [tradingAccountInfo release];
    [tradingAccountsPopover release];
    
    [yourAccountsButton release];
    [super dealloc];
}

- (void)viewDidUnload {
    [userNameLabel release];
    userNameLabel = nil;
    [tradingInLabel release];
    tradingInLabel = nil;
    [yourAccountsButton release];
    yourAccountsButton = nil;
    [super viewDidUnload];
}

- (IBAction)yourAccountsPressed:(id)sender
{
    tradingAccountsPopover.tradingAccounts = tradingAccountInfo.TradingAccounts;
    
    UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:tradingAccountsPopover];
    popOver.popoverContentSize = CGSizeMake(300, 200);
    
    [popOver presentPopoverFromRect:yourAccountsButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)addAMarketButtonPressed:(id)sender {
    MarketListViewController *marketList = [[MarketListViewController alloc] initWithNibName:@"MarketListViewController" bundle:nil];
    marketList.modalPresentationStyle = UIModalPresentationFormSheet;
    marketList.apiClient = client;
    marketList.clientAccountID = tradingAccountInfo.ClientAccountId;
    
    [self presentModalViewController:marketList animated:YES];
    
    [marketList release];

}

@end
