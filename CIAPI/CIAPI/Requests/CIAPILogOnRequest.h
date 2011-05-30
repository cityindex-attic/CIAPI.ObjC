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
 NSString* UserName;
 NSString* Password;
}

// Username is case sensitive 
@property (retain) NSString* UserName;
// Password is case sensitive 
@property (retain) NSString* Password;

@end
