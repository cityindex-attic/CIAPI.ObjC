//
//  CIAPIListStopLimitOrderHistoryResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListStopLimitOrderHistoryResponse : CIAPIObjectListResponse {
  NSArray* StopLimitOrderHistory;
}

// A list of historical stop / limit orders. 
@property (readonly) NSArray* StopLimitOrderHistory;

@end
