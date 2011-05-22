//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIErrorResponse : CIAPIObjectResponse {
  id ErrorMessage;
  id ErrorCode;
}

// This is a description of the ErrorMessage property 
@property (readonly) id ErrorMessage;
// The error code 
@property (readonly) id ErrorCode;

@end
