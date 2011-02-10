//
//  AddValueDetailCell.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 08/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddValueDetailCell : UITableViewCell {

	UITextField *_cellField;
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UITextField *cellField;

@end
