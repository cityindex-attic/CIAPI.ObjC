//
//  ServerSingleDetailViewController.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 06/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServerSingleDetailView : UIView {
	UITableView *_table;
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UITableView *table;

@end
