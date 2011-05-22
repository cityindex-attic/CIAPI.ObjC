//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIClientAccountWatchlist : NSObject {
  id WatchlistId;
  id WatchlistDescription;
  id DisplayOrder;
  id Items;
}

// Watchlist item id 
@property (readonly) id WatchlistId;
// Watchlist description 
@property (readonly) id WatchlistDescription;
// Watchlist display order 
@property (readonly) id DisplayOrder;
// Watchlist items 
@property (readonly) id Items;

@end
