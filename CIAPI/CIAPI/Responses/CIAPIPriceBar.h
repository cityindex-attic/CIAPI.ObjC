//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIPriceBar : CIAPIObjectResponse {
  NSString* BarDate;
  double Open;
  double High;
  double Low;
  double Close;
}

// The date of the start of the price bar interval 
@property (readonly) NSString* BarDate;
// For the equities model of charting, this is the price at the start of the price bar interval. 
@property (readonly) double Open;
// The highest price occurring during the interval of the price bar 
@property (readonly) double High;
// The lowest price occurring during the interval of the price bar 
@property (readonly) double Low;
// The price at the end of the price bar interval 
@property (readonly) double Close;

@end
