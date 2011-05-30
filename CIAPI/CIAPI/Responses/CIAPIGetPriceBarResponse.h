//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIPriceBar.h"


@interface CIAPIGetPriceBarResponse : CIAPIObjectResponse {
  NSArray* PriceBars;
  CIAPIPriceBar* PartialPriceBar;
}

// An array of finalized price bars, sorted in ascending order based on PriceBar.BarDate 
@property (readonly) NSArray* PriceBars;
// The (non-finalized) price bar data for the current period (i.e, the period that hasn't yet completed) 
@property (readonly) CIAPIPriceBar* PartialPriceBar;

@end
