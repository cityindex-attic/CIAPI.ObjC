//
//  CityPadDashboardViewController.h
//  CityPad
//
//  Created by Adam Wright on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CIAPI.h"

#import "CityPadDashboardViewController.h"
#import "TradingAccountListViewController.h"


@interface CityPadDashboardViewController : UIViewController
{
    CIAPIClient *client;
    IBOutlet UILabel *userNameLabel;
    IBOutlet UILabel *tradingInLabel;
    IBOutlet UIButton *yourAccountsButton;
    
    CIAPIAccountInformationResponse *tradingAccountInfo;
    TradingAccountListViewController *tradingAccountsPopover;
}

@property (retain) CIAPIClient *client;

- (IBAction)yourAccountsPressed:(id)sender;
- (IBAction)addAMarketButtonPressed:(id)sender;

@end
