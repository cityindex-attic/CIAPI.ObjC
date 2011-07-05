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

@interface CityPadDashboardViewController : UIViewController
{
    CIAPIClient *client;
}

@property (retain) CIAPIClient *client;

@end
