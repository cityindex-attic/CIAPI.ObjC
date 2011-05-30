//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIListWatchlistResponse : CIAPIObjectListResponse {
  NSInteger ClientAccountId;
}

// Client account id 
@property (readonly) NSInteger ClientAccountId;

@end
