//
//  CIAPIClientAccountWatchlist.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIClientAccountWatchlist : CIAPIObjectResponse {
  NSInteger WatchlistId;
  NSString* WatchlistDescription;
  NSInteger DisplayOrder;
  NSArray* Items;
}

// Watchlist item id 
@property (readonly) NSInteger WatchlistId;
// Watchlist description 
@property (readonly) NSString* WatchlistDescription;
// Watchlist display order 
@property (readonly) NSInteger DisplayOrder;
// Watchlist items 
@property (readonly) NSArray* Items;

@end
