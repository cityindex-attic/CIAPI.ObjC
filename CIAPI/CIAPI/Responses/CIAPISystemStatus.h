//
//  CIAPISystemStatus.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPISystemStatus : CIAPIObjectResponse {
  NSString* StatusMessage;
}

// a status message 
@property (readonly) NSString* StatusMessage;

@end
