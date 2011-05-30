//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListTradeHistoryResponse : CIAPIObjectListResponse {
  NSArray* TradeHistory;
}

// A list of historical trades. 
@property (readonly) NSArray* TradeHistory;

@end
