//
//  ServerStreamViewController.m
//  Lightstreamer explorer
//
//  Created by Marco Vannucci on 15/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import "ServerStreamViewController.h"
#import "ServerStreamView.h"
#import "LSListener.h"
#import "LSClient.h"
#import "LSSession.h"
#import "LSSessionOptions.h"
#import "LSUnchangedValue.h"
#import "Reachability.h"

#define HIGHLIGHT_COLOR greenColor
#define BASE_COLOR clearColor


@implementation ServerStreamViewController


#pragma mark -
#pragma mark Initialization and Deallocation

- (id) initWithServer:(ServerConfig *)server {
	
	self = [super init];
	if (self) {
		
		// Initialize attribute
		_server = [server retain];
		_itemStates = [[NSMutableArray alloc] init];
		_rowsNumber = 0;
		
		// Define base and highlight color of the cells
		_highlightColor = [[UIColor HIGHLIGHT_COLOR] retain];
		_baseColor = [[UIColor BASE_COLOR] retain];
		_waitingConnection = [[NSNumber alloc] initWithBool:NO];
		
		// Create lightstreamer client connection
		_client = [[LSClient alloc] initWithServerURL:[NSURL URLWithString:_server.address]];
	}
	return self;
}


- (void)dealloc {

	// Synchronized block of release. Each variable could be accessed at the same time by main thread and background open connection thread
	@synchronized(_client) {
		[_client release];
		_client = nil;
		[_server release];
		[_waitingConnection release];
		[_session release];
	}

	[_highlightColor release];
	[_baseColor release];
	[super dealloc];
}


#pragma mark -
#pragma mark Methods of UIViewController

- (void) loadView {

	// Load view from nib file
	ServerStreamView *serverStreamView = [[[NSBundle mainBundle] loadNibNamed:@"ServerStreamView" owner:self options:nil] lastObject];
	self.view = serverStreamView;
	
	// Define close button action
	serverStreamView.close.target = self;
	serverStreamView.close.action = @selector(close);
}


- (void) viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	// Open connection in background thread, setting the waiting connetion variable to true
	[_waitingConnection release];
	_waitingConnection = [[NSNumber alloc] initWithBool:YES];
	[self performSelectorInBackground:@selector(openSession) withObject:nil];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

	// Can rotate to any orientation
	return YES;
}


#pragma mark -
#pragma mark Methods of UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	// One section only
	return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	// The number of fields
	return _rowsNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Shows a standard cell with adjustable font size, whith the value indicated by itemState at the specified index path
	
	// Common behaviour of tableview:cellForRowAtIndexPath
	static NSString *standardCellId = @"StandardCell";
	UITableViewCell *cell = [((ServerStreamView *) self.view).table dequeueReusableCellWithIdentifier:standardCellId];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:standardCellId] autorelease];
		UILabel *label = cell.textLabel;
		label.minimumFontSize = 10;
		label.adjustsFontSizeToFitWidth = YES;
		// On iOS 4.2 it is possible define label background color to clearColor, without redefine it on tableView:willDisplayCell:forRowAtIndexPath:
		// That does not happen on previous version.
	}
	
	ItemState *itemState = [_itemStates objectAtIndex:indexPath.row];
	@synchronized(itemState) {
		cell.textLabel.text = [itemState.value componentsJoinedByString:@", "];
	}
	return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

	// Cells color management must be defined in this method, as described on method discussion API
	// In case the item state at the index path position is to update, the background of the cell must be of the highlight color, else base
	ItemState *itemState = [_itemStates objectAtIndex:indexPath.row];
	UIColor *color = _baseColor;
	@synchronized(itemState) {
		if (itemState.toUpdate)
			color = _highlightColor;
	}
	
	cell.contentView.backgroundColor = cell.textLabel.backgroundColor = color;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// No cell selectables
	return nil;
}


#pragma mark -
#pragma mark Methods of LSListener

- (void) onUpdate:(LSSession *)session window:(NSInteger)window table:(NSInteger)table item:(NSInteger)item values:(NSArray *)values {
	
	// Set defaul value to show
	static NSString *defautValue = @" - ";
	
	[values retain];
	// If the item number is grater than the one already available it is necessary create any item state between the grater in the array and the item number
	if (item > [_itemStates count])
		for (NSInteger i = [_itemStates count]; i < item; i++) {
			ItemState *newState = [[ItemState alloc] init];
			[_itemStates addObject:newState];
			[newState release];
		}
	
	// It is also necessary insert the necessary row in the table
	if (item > _rowsNumber) {
		NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:(item - _rowsNumber)];
		for (NSUInteger i = _rowsNumber; i < item; i++)
			[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
		
		// A syncronization on change on row number and the insertion a new row in this thread, with the reloadRowAtIndexPath: selector 
		// perfomed on the main thread, it is necessary in order to avoid exception on the number of rows in section 0
		@synchronized(_server) {
			_rowsNumber = item;
			[((ServerStreamView *) self.view).table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
		}
		[indexPaths release];
	}
	
	
	NSInteger zeroBaseItem = item - 1;
	NSIndexPath *toReload = [NSIndexPath indexPathForRow:zeroBaseItem inSection:0];
	
	// Take item state and prevent any read or write operation on it with a synchronization lock
	ItemState *itemState = [_itemStates objectAtIndex:zeroBaseItem];
	@synchronized(itemState) {
		// Define item as an update
		itemState.toUpdate = YES;
		
		// Change the old value with the new one. If the new value is an instance of LSUnchangedValue, than the old value has not changed
		for (NSUInteger i = 0; i < [values count]; i++) {
			NSObject *value = [values objectAtIndex:i];
			
			if ([value isKindOfClass:[LSUnchangedValue class]])
				continue;
			
			// If the value is nil, than the dafault value string is shown
			NSString *strValue = (NSString *) value;
			if (!strValue)
				strValue = defautValue;
			
			// If the item has alredy a value at the same posiotion, than it must bereplaced, else this new value must be added to the list
			if ([itemState.value count] > i)
				[itemState.value replaceObjectAtIndex:i withObject:strValue];
			else
				[itemState.value addObject:strValue];
		}
	}
	
	// Refresh the row with the new value on main thread
	[self performSelectorOnMainThread:@selector(reloadRowAtIndexPath:) withObject:toReload waitUntilDone:NO];
	
	// Stop the flash effect after 0.3 sec. 
	[self performSelector:@selector(stopFlashing:) withObject:toReload afterDelay:0.3f];
	[values release];
}


- (void) onException:(LSSession *)session exception:(LSException *)exception {
	
	// Exception are printed on log, but not show to the user
	NSLog(@"LSException has been raised. Description: %@ \n Reason: %@", [exception description], [exception reason]);
}


#pragma mark -
#pragma mark Internal methods


- (void) openSession {

	// This method is performed in a background thread. It is necessary define an autorelease pool
	NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
	LSSessionOptions *options = nil;
	LSClient *tmpClient = nil;
	LSSession *tmpSession = nil;
	
	@try {
		// Verify network status
		NSString *networkErrorTitle = [self checkNetworkStatus];
		if (networkErrorTitle) {
			[self showAlertWithTitle:networkErrorTitle andMessage:@"Please try again later"];
			return;
		}
		
		// Retain the client and the server locking this operation on the client object. That work because the release of these object
		// is synchronized on the same object
		@synchronized (_client) {
			if (!_client)
				return;
			
			tmpClient = [_client retain];
			[_server retain];
		}
		
		// Create session
		options = [[LSSessionOptions alloc] init];
		tmpSession = [[tmpClient createSession:_server.user password:_server.password adapterSet:_server.adapterSet listener:self options:options autorebind:YES] retain];
		
		// If session is valid, subscribe fields with the defined schema and option
		if (tmpSession.isConnected) {
			[tmpSession add:1 adapter:_server.adapter table:1 group:_server.group schema:_server.schema selector:_server.selector mode:[_server.mode intValue] requestedBufferSize:[_server.bufferSize intValue] requestedMaxFrequency:[_server.maxFrequency doubleValue] snapshot:YES];
			
			// If the view controller is jet waiting for the connection than assign, in a synchronized way, the created session to the session variable and set the waiting connection variable to false
			@synchronized(_waitingConnection) {
				if ([_waitingConnection boolValue]) {
					_session = [tmpSession retain];
					[_waitingConnection release];
					_waitingConnection = [[NSNumber alloc] initWithBool:NO];
				}
				else
					[tmpSession destroy];			
			}
		}
		[_server release];
	}
	@catch (LSException *lse) {
		[self showAlertWithTitle:@"Lightstreamer exception" andMessage:[lse reason]];
	}
	@finally {
		[options release];
		[tmpSession release];
		[tmpClient release];
		[autoreleasePool drain];
	}
}


// Cell Flashing controllers

- (void) reloadRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// reloadOfRowAtIndexPath:withRowAnimation: is synchronized with the change on row number and insertion of new rows into the onUpdateonUpdate:window:table:item:values:
	NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
	@synchronized(_server) {
		[((ServerStreamView *) self.view).table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
	}
	[indexPaths release];
}


- (void) stopFlashing:(NSIndexPath *)indexPath {
	
	// Change item state state
	ItemState *itemState = [_itemStates objectAtIndex:indexPath.row];
	@synchronized (itemState) {
		itemState.toUpdate = NO;
	}
	
	[self performSelectorOnMainThread:@selector(reloadRowAtIndexPath:) withObject:indexPath waitUntilDone:NO];
}


// Close button action

- (void) close {
	
	// If the close button has been pushed before the connection has been established, the controller is no more waiting for the connection.
	// Else it is necessary destroy the created session.
	@synchronized(_waitingConnection){

		if ([_waitingConnection boolValue]) {
			[_waitingConnection release];
			_waitingConnection = [[NSNumber alloc] initWithBool:NO];
		}
		else
			[_session destroy];
	}
	
	// Remove any pending stopFlashing request
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	// Dismiss modal view
	[self dismissModalViewControllerAnimated:YES];
}


// NetworkStatus check

- (NSString *) checkNetworkStatus {
	
	// Verify if the network is reachable
	Reachability *reachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [reachability currentReachabilityStatus];
	if (networkStatus == NotReachable)
		return @"Network is unreachable";
	
	// Verify if the connection is available
	if ([reachability connectionRequired])
		return @"Connection not available";

	// Everything is reachable
	return nil;
}


// Show alert view

- (void) showAlertWithTitle:(NSString *)title andMessage:(NSString *)message  {
	
	// Show an alert view with the defined title, an ok button and the prefixed message, without defining the delegate
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
	[alertView release];
}

@end
