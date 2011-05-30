//
//  CIAPIIfDoneResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIOrderResponse.h"
#import "CIAPIOrderResponse.h"


@interface CIAPIIfDoneResponse : CIAPIObjectResponse {
  CIAPIOrderResponse* Stop;
  CIAPIOrderResponse* Limit;
}

// Stop 
@property (readonly) CIAPIOrderResponse* Stop;
// Limit 
@property (readonly) CIAPIOrderResponse* Limit;

@end
