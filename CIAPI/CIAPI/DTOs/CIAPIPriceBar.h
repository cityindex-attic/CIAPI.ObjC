// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//The details of a specific price bar, useful for plotting candlestick charts
@interface CIAPIPriceBar : NSObject 
{
  NSNumber *Open;
  NSString *BarDate;
  NSNumber *Close;
  NSNumber *High;
  NSNumber *Low;
}

// The price at the open of the price bar interval
@property (retain) NSNumber *Open;

// The date of the start of the price bar interval
@property (retain) NSString *BarDate;

// The price at the end of the price bar interval
@property (retain) NSNumber *Close;

// The highest price occuring during the interval of the price bar
@property (retain) NSNumber *High;

// The lowest price occuring during the interval of the price bar
@property (retain) NSNumber *Low;

@end

