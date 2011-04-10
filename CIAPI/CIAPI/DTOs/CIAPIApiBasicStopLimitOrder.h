// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//TODO
@interface CIAPIApiBasicStopLimitOrder : NSObject<RKObjectMappable> 
{
  int OrderId;
  NSNumber *TriggerPrice;
}

// The order's unique identifier.
@property int OrderId;

// The order's trigger price.
@property (retain) NSNumber *TriggerPrice;

@end

