//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIPriceBar : NSObject {
  id BarDate;
  id Open;
  id High;
  id Low;
  id Close;
}

// The date of the start of the price bar interval 
@property (readonly) id BarDate;
// For the equities model of charting, this is the price at the start of the price bar interval. 
@property (readonly) id Open;
// The highest price occurring during the interval of the price bar 
@property (readonly) id High;
// The lowest price occurring during the interval of the price bar 
@property (readonly) id Low;
// The price at the end of the price bar interval 
@property (readonly) id Close;

@end
