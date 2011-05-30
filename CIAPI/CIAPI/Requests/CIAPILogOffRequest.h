//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPILogOffRequest : CIAPIObjectResponse {
  NSString* UserName;
  NSString* Session;
}

// user name of the session to delete (log off). 
@property (readonly) NSString* UserName;
// session identifier of the session to delete (log off). 
@property (readonly) NSString* Session;

@end
