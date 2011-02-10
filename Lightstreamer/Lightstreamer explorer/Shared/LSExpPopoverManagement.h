//
//  LSExpPopoverManagement.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 24/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ServerConfig.h"

@protocol LSExpPopoverManagement

@property (retain) UIPopoverController *popOverController;
@property (retain) ServerConfig *server;

@end
