//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIIfDoneResponse : CIAPIObjectResponse {
  id Stop;
  id Limit;
}

// Stop 
@property (readonly) id Stop;
// Limit 
@property (readonly) id Limit;

@end
