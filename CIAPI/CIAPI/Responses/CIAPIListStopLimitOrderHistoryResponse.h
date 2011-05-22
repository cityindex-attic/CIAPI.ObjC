//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListStopLimitOrderHistoryResponse : CIAPIObjectListResponse {
  id StopLimitOrderHistory;
}

// A list of historical stop / limit orders. 
@property (readonly) id StopLimitOrderHistory;

@end
