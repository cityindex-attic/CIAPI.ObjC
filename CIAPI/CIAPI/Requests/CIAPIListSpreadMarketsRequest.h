//
//  CIAPIListSpreadMarketsRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Returns a list of Spread Betting markets filtered by market name and/or marke
// t code
 
@interface CIAPIListSpreadMarketsRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* searchByMarketName;
  NSString* searchByMarketCode;
  NSInteger clientAccountId;
  NSInteger maxResults;
}

// Properties for each field
// The characters that the Spread market name should start with 
@property (retain) NSString* searchByMarketName;
// The characters that the Spread market code should start with (normally this is the RIC code for the market) 
@property (retain) NSString* searchByMarketCode;
// The logged on user's ClientAccountId.  (This only shows you markets that you can trade on) 
@property  NSInteger clientAccountId;
// The maximum number of markets to return. 
@property  NSInteger maxResults;

// Constructor for the object
- (CIAPIListSpreadMarketsRequest*)initWithSearchByMarketName:(NSString*)_searchByMarketName searchByMarketCode:(NSString*)_searchByMarketCode clientAccountId:(NSInteger)_clientAccountId;


@end

