//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPILogOnResponse : CIAPIObjectResponse {
  NSString* Session;
}

// Your session token (treat as a random string) <BR /> Session tokens are valid for a set period from the time of their creation. <BR /> The period is subject to change, and may vary depending on who you logon as. 
@property (readonly) NSString* Session;

@end
