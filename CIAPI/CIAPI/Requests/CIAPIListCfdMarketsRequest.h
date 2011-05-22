//
//  CIAPIListCfdMarketsRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

// Returns a list of CFD markets filtered by market name and/or market code
 
@interface CIAPIListCfdMarketsRequest : CIAPIObjectRequest {
  id searchByMarketName;
  id searchByMarketCode;
  id clientAccountId;
  id maxResults;
}

  // The characters that the CFD market name should start with 
  @property (retain) id searchByMarketName;
  // The characters that the market code should start with (normally this is the RIC code for the market) 
  @property (retain) id searchByMarketCode;
  // The logged on user's ClientAccountId.  (This only shows you markets that you can trade on) 
  @property (retain) id clientAccountId;
  // The maximum number of markets to return. 
  @property (retain) id maxResults;

@end
