//
//  CIAPIDeleteSessionRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Delete a session. This is how you "log off" from the CIAPI.</p>
 
@interface CIAPIDeleteSessionRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* userName;
  NSString* session;
}

// Properties for each field
// Username is case sensitive. May be set as a service parameter or as a request header. 
@property (retain) NSString* userName;
// The session token. May be set as a service parameter or as a request header. 
@property (retain) NSString* session;

// Constructor for the object
- (CIAPIDeleteSessionRequest*)initWithUserName:(NSString*)_userName session:(NSString*)_session;


@end

