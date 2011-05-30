//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPISystemStatusRequest : CIAPIObjectResponse {
  NSString* TestDepth;
}

// depth to test. 
@property (readonly) NSString* TestDepth;

@end
