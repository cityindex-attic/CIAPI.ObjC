//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIClientAccountWatchlistItem : NSObject {
  id WatchlistId;
  id MarketId;
  id DisplayOrder;
}

// Parent watchlist id 
@property (readonly) id WatchlistId;
// Watchlist item market id 
@property (readonly) id MarketId;
// Watchlist item display order 
@property (readonly) id DisplayOrder;

@end
