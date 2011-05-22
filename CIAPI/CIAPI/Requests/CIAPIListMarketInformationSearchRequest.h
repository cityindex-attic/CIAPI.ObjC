//
//  CIAPIListMarketInformationSearchRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

// <p>Queries for market information.</p>
 
@interface CIAPIListMarketInformationSearchRequest : CIAPIObjectRequest {
  id searchByMarketCode;
  id searchByMarketName;
  id spreadProductType;
  id cfdProductType;
  id binaryProductType;
  id query;
  id maxResults;
}

  // Should the search be done by market code 
  @property (retain) id searchByMarketCode;
  // Should the search be done by market Name 
  @property (retain) id searchByMarketName;
  // Should the search include spread bet markets 
  @property (retain) id spreadProductType;
  // Should the search include CFD markets 
  @property (retain) id cfdProductType;
  // Should the search include binary markets 
  @property (retain) id binaryProductType;
  // The text to search for.  Matches part of market name / code from the start. 
  @property (retain) id query;
  // The maximum number of results to return 
  @property (retain) id maxResults;

@end
