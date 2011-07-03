//
//  CIAPIGetMarketInformationRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// <p>Get Market Information for the specified market.</p>
 
@interface CIAPIGetMarketInformationRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* marketId;
}

// Properties for each field
// The marketId 
@property (retain) NSString* marketId;

// Constructor for the object
- (CIAPIGetMarketInformationRequest*)initWithMarketId:(NSString*)_marketId;


@end

