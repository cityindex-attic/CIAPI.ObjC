//
//  TradingAccountListViewController.h
//  CityPad
//
//  Created by Adam Wright on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CIAPI.h"

@interface TradingAccountListViewController : UIViewController {
    UITableView *tableView;
    NSArray *tradingAccounts;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (retain) NSArray *tradingAccounts;

@end
