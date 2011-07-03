//
//  CIAPIGenerateExceptionRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Simulates an error condition.
 
@interface CIAPIGenerateExceptionRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSInteger errorCode;
}

// Properties for each field
// Simulates an error condition. 
@property  NSInteger errorCode;

// Constructor for the object
- (CIAPIGenerateExceptionRequest*)initWithErrorCode:(NSInteger)_errorCode;


@end

