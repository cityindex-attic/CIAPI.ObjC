//
//  DetailSelectionView.h
//  Lightstreamer explorer
//
//  Created by Il Fenomeno on 14/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//



@interface DetailSelectionView : UIView {

@private
	UIView *_container;
	UIToolbar *_toolbar;
	UIPickerView *_values;
	UIBarButtonItem *_doneButton;
	UIBarButtonItem *_cancelButton;
	UIBarButtonItem *_flexibleSpace;
	
}

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) IBOutlet UIView *container;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIPickerView *values;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexibleSpace;

@end
