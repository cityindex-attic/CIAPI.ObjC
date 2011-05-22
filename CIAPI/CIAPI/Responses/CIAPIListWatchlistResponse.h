//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIListWatchlistResponse : CIAPIObjectListResponse {
  id ClientAccountId;
}

// Client account id 
@property (readonly) id ClientAccountId;

@end
