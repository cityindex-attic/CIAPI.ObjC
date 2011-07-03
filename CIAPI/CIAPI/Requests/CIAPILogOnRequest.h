//
//  CIAPILogOnRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Create a new session. This is how you "log on" to the CIAPI. Post a <a onc
// lick="dojo.hash('#type.ApiLogOnRequestDTO'); return false;" class="json-link"
//  href="#">ApiLogOnRequestDTO</a> to the uri specified below</p>
 
@interface CIAPILogOnRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* UserName;
  NSString* Password;
}

// Properties for each field
// Username is case sensitive 
@property (retain) NSString* UserName;
// Password is case sensitive 
@property (retain) NSString* Password;

// Constructor for the object
- (CIAPILogOnRequest*)initWithUserName:(NSString*)_UserName password:(NSString*)_Password;


@end

