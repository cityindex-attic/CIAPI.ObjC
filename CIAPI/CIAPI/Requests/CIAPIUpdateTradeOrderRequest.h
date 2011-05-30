//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIUpdateTradeOrderRequest : CIAPIObjectResponse {
  NSInteger OrderId;
}

// Order identifier of the order to update 
@property (readonly) NSInteger OrderId;

@end
