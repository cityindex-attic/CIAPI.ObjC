//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIOpenPosition.h"


@interface CIAPIGetOpenPositionResponse : CIAPIObjectResponse {
  CIAPIOpenPosition* OpenPosition;
}

// The open position. If it is null then the open position does not exist. 
@property (readonly) CIAPIOpenPosition* OpenPosition;

@end
