//
//  CIAPISaveWatchlistRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIClientAccountWatchlist.h"


@interface CIAPISaveWatchlistRequest : CIAPIObjectResponse {
  CIAPIClientAccountWatchlist* Watchlist;
}

// The watchlist to save. This will update an existing watchlist; or when the watchlistId is omitted or 0 is supplied, will create a new watchlist. 
@property (readonly) CIAPIClientAccountWatchlist* Watchlist;

@end
