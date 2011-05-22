//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPILogOffResponse : CIAPIObjectResponse {
  id LoggedOut;
}

// LogOut status 
@property (readonly) id LoggedOut;

@end
