//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPISystemStatus : NSObject {
  id StatusMessage;
}

// a status message 
@property (readonly) id StatusMessage;

@end
