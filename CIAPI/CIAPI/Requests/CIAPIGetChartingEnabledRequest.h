//
//  CIAPIGetChartingEnabledRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"


// Whether a User is allowed to see Charting Data.
 
@interface CIAPIGetChartingEnabledRequest : CIAPIObjectRequest {

  // Instance variables for all fields
  NSString* ident;
}

// Properties for each field
// Whether a User is allowed to see Charting Data. 
@property (retain) NSString* ident;

// Constructor for the object
- (CIAPIGetChartingEnabledRequest*)initWithIdent:(NSString*)_ident;


@end

