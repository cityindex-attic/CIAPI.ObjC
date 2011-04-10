// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "CIAPIGatewayStopLimitOrder.h"
#import "CIAPIGatewayStopLimitOrder.h"

//An IfDone order represents an order which is placed when the corresponding order is filled, e.g attaching a stop/limit to a trade or order
@interface CIAPIGatewayIfDone : NSObject<RKObjectMappable> 
{
  CIAPIGatewayStopLimitOrder *Stop;
  CIAPIGatewayStopLimitOrder *Limit;
}

// The price at which the stop order will be filled
@property (retain) CIAPIGatewayStopLimitOrder *Stop;

// The price at which the limit order will be filled
@property (retain) CIAPIGatewayStopLimitOrder *Limit;

@end

