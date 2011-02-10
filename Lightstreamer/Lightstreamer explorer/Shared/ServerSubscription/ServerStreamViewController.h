//
//  ServerStreamViewController.h
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConfig.h"
#import "LSListener.h"
#import "LSClient.h"
#import "ItemState.h"

@interface ServerStreamViewController : UITableViewController <LSListener> {

@private
	// Variable used to store the request status of connection.
	NSNumber *_waitingConnection;
	// The server configuration
	ServerConfig *_server;
	// iStreamLight client and session variables
	LSClient *_client;
	LSSession *_session;
	
	// Take trace of the number of row into the table
	NSInteger _rowsNumber;
	// Is an array of ItemState. Store the received information and the state of the field. 
	NSMutableArray *_itemStates;
	
	// Highlight color and base color of the cell
	UIColor *_highlightColor;
	UIColor *_baseColor;
}

#pragma mark -
#pragma mark Initialization method

- (id) initWithServer:(ServerConfig *)server;

#pragma mark -
#pragma mark Internal methods

// Manage the cell flashing
- (void) reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) stopFlashing:(NSIndexPath *)indexPath;

// Close button action selector
- (void) close;

// Verify internet connection and server address connection. Return nil if connection is reachable, else a messagge error.
- (NSString *) checkNetworkStatus;

// Show an alert view with the define title
- (void) showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end




