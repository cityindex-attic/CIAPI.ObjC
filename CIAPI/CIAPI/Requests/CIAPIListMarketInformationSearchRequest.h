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

  // Instance variables for all fields
  BOOL searchByMarketCode;
  BOOL searchByMarketName;
  BOOL spreadProductType;
  BOOL cfdProductType;
  BOOL binaryProductType;
  NSString* query;
  NSInteger maxResults;
}

// Properties for each field
// Should the search be done by market code 
@property  BOOL searchByMarketCode;
// Should the search be done by market Name 
@property  BOOL searchByMarketName;
// Should the search include spread bet markets 
@property  BOOL spreadProductType;
// Should the search include CFD markets 
@property  BOOL cfdProductType;
// Should the search include binary markets 
@property  BOOL binaryProductType;
// The text to search for.  Matches part of market name / code from the start. 
@property (retain) NSString* query;
// The maximum number of results to return 
@property  NSInteger maxResults;

// Constructor for the object
- (CIAPIListMarketInformationSearchRequest*)initWithSearchByMarketCode:(BOOL)_searchByMarketCode searchByMarketName:(BOOL)_searchByMarketName spreadProductType:(BOOL)_spreadProductType cfdProductType:(BOOL)_cfdProductType binaryProductType:(BOOL)_binaryProductType query:(NSString*)_query maxResults:(NSInteger)_maxResults;


@end

