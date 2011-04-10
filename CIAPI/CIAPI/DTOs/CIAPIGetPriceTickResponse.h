// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//The response from a request for Price Ticks
@interface CIAPIGetPriceTickResponse : NSObject<RKObjectMappable> 
{
  NSMutableArray *PriceTicks;
}

// An array of price ticks, sorted in ascending order by PriceTick.TickDate
@property (retain) NSMutableArray *PriceTicks;

@end

