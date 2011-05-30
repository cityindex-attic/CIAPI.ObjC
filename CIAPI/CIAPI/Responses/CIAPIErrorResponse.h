//
//  CIAPIErrorResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIErrorCode.h"


@interface CIAPIErrorResponse : CIAPIObjectResponse {
  NSString* ErrorMessage;
  CIAPIErrorCode* ErrorCode;
}

// This is a description of the ErrorMessage property 
@property (readonly) NSString* ErrorMessage;
// The error code 
@property (readonly) CIAPIErrorCode* ErrorCode;

@end
