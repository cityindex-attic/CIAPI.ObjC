// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//TODO
@interface CIAPIApiBasicStopLimitOrder : NSObject 
{
  int OrderId;
  NSNumber *TriggerPrice;
}

// The order's unique identifier.
@property int OrderId;

// The order's trigger price.
@property (retain) NSNumber *TriggerPrice;

@end

