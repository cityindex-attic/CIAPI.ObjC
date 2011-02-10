//
//  ServerDetailsView.h
//
//  Created by Marco Vannucci on 03/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ServerDetailsView : UIView {
	UITableView *_table;
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UITableView *table;

@end
