//
//  ServerStreamView.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerStreamView : UIView {
	
@private
	UIToolbar *_toolbar;
	UITableView *_table;
	UIBarButtonItem *_fixedSpace;
	UIBarButtonItem *_flexibleSpaceLeft;
	UIBarButtonItem *_title;
	UIBarButtonItem *_flexibleSpaceRight;
	UIBarButtonItem *_close;
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *fixedSpace;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexibleSpaceLeft;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *title;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexibleSpaceRight;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *close;

@end
