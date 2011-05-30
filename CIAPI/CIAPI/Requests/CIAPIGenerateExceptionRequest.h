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
 NSInteger errorCode;
}

// Simulates an error condition. 
@property  NSInteger errorCode;

@end
