//
//  SingleDetail.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 11/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConfig.h"
#import "ServerDetailsViewController.h"

// This object should be use as information messanger between ServerDetailViewController and ServerSingleDetailViewController
@interface SingleDetail : NSObject {

@private
	// Any object attribute reflect the meaning of its related property
	ServerConfig *_server;
	NSString *_valuesName;
	NSString *_valuesClassName;
	NSString *_propertyName;
	SEL _addValuesSelector;
	SEL _removeValueSelector;

	ServerDetailsViewController *_previousViewController;
}

// Server from which retrive the detail
@property (nonatomic, retain) ServerConfig *server;

// Descriptive name of the detail to show
@property (nonatomic, retain) NSString *valuesName;

// Class object of the detail to show
@property (nonatomic, retain) NSString *valuesClassName;

// Property name of the detail from server
@property (nonatomic, retain) NSString *propertyName;

// Selector to add reference of a set of detail to the server
@property SEL addValuesSelector;

// Selector to remove a reference of a detail to the server
@property SEL removeValueSelector;

@property (nonatomic, retain) ServerDetailsViewController *previousViewController;

@end
