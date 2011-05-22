//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListTradeHistoryResponse : CIAPIObjectListResponse {
  id TradeHistory;
}

// A list of historical trades. 
@property (readonly) id TradeHistory;

@end
