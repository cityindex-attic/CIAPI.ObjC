// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//The mid price at a particular point in time.
@interface CIAPIPriceTick : NSObject 
{
  NSString *TickDate;
  NSNumber *Price;
}

// The datetime at which a price tick occured. Accurate to the millisecond
@property (retain) NSString *TickDate;

// The mid price
@property (retain) NSNumber *Price;

@end

