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
  id errorCode;
}

  // Simulates an error condition. 
  @property (retain) id errorCode;

@end
