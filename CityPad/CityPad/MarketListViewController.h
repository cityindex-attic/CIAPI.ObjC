//
//  MarketListViewController.h
//  CityPad
//
//  Created by Adam Wright on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CIAPI.h"

@interface MarketListViewController : UIViewController {
    UITableView *marketTable;
    CIAPIClient *apiClient;
    NSInteger clientAccountID;
    CIAPIListSpreadMarketsResponse *markets;
}

@property (nonatomic, retain) IBOutlet UITableView *marketTable;
@property (retain) CIAPIClient *apiClient;
@property (assign) NSInteger clientAccountID;

@end
