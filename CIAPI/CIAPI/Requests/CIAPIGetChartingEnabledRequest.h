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
 NSString* ident;
}

// Whether a User is allowed to see Charting Data. 
@property (retain) NSString* ident;

@end
