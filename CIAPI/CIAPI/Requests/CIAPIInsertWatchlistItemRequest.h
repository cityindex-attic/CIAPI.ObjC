//
//  CIAPIInsertWatchlistItemRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIInsertWatchlistItemRequest : CIAPIObjectResponse {
  NSInteger ParentWatchlistDisplayOrderId;
  NSInteger MarketId;
}

// The watchlist display order id to add the item 
@property (readonly) NSInteger ParentWatchlistDisplayOrderId;
// The market item to add 
@property (readonly) NSInteger MarketId;

@end
