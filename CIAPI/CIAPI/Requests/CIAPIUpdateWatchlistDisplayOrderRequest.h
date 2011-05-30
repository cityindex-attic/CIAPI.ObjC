//
//  CIAPIUpdateWatchlistDisplayOrderRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIUpdateWatchlistDisplayOrderRequest : CIAPIObjectResponse {
  NSArray* NewDisplayOrderIdSequence;
}

// Represents the new client watchlist displayOrderId list sequence 
@property (readonly) NSArray* NewDisplayOrderIdSequence;

@end
