// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//The response from a GET price bar history request. Contains both an array of finalized price bars, and a partial (not finalized) bar for the current period
@interface CIAPIGetPriceBarResponse : NSObject<RKObjectMappable> 
{
  NSMutableArray *PriceBars;
}

// An array of finalized price bars, sorted in ascending order based on PriceBar.BarDate
@property (retain) NSMutableArray *PriceBars;

@end

