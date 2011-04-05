// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//The response from a GET price bar history request. Contains both an array of finalized price bars, and a partial (not finalized) bar for the current period
@interface CIAPIGetPriceBarResponse : NSObject 
{
  NSMutableArray *PriceBars;
}

// An array of finalized price bars, sorted in ascending order based on PriceBar.BarDate
@property (retain) NSMutableArray *PriceBars;

@end

