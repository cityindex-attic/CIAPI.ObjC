//
//  CIAPIClientAccountWatchlistItem.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIClientAccountWatchlistItem : CIAPIObjectResponse {
  NSInteger WatchlistId;
  NSInteger MarketId;
  NSInteger DisplayOrder;
}

// Parent watchlist id 
@property (readonly) NSInteger WatchlistId;
// Watchlist item market id 
@property (readonly) NSInteger MarketId;
// Watchlist item display order 
@property (readonly) NSInteger DisplayOrder;

@end
