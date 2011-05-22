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
  id userName;
  id session;
}

  // Username is case sensitive. May be set as a service parameter or as a request header. 
  @property (retain) id userName;
  // The session token. May be set as a service parameter or as a request header. 
  @property (retain) id session;

@end
