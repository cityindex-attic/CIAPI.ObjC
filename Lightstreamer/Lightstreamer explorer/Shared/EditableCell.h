//
//  EditableCell.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableCell : UITableViewCell {
	
@private
	UILabel *_cellLabel;
	UITextField *_cellField;
}


#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) IBOutlet UILabel *cellLabel;
@property (nonatomic, readonly) IBOutlet UITextField *cellField;


@end
