//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIIfDone : NSObject {
  id Stop;
  id Limit;
}

// The price at which the stop order will be filled 
@property (readonly) id Stop;
// The price at which the limit order will be filled 
@property (readonly) id Limit;

@end
