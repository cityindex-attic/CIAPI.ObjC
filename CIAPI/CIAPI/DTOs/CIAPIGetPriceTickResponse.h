// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//The response from a request for Price Ticks
@interface CIAPIGetPriceTickResponse : NSObject 
{
  NSMutableArray *PriceTicks;
}

// An array of price ticks, sorted in ascending order by PriceTick.TickDate
@property (retain) NSMutableArray *PriceTicks;

@end

