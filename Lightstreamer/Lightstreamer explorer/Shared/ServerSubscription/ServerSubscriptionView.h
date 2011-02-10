//
//  ServerSubscriptionView.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 13/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerSubscriptionView : UIView {
	
	UITableView *_table;
	UIView *_footerView;
	UIButton *_subscribe;
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UITableView *table;
@property (nonatomic, readonly) IBOutlet UIView *footerView;
@property (nonatomic, readonly) IBOutlet UIButton *subscribe;

@end
