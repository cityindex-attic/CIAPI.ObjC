//
//  ServerListView.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServerListView : UIView {
	
	UITableView *_table;
}


#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UITableView *table;


@end
