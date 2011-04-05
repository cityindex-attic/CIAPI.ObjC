// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPIGatewayStopLimitOrder.h"
#import "CIAPIGatewayStopLimitOrder.h"

//An IfDone order represents an order which is placed when the corresponding order is filled, e.g attaching a stop/limit to a trade or order
@interface CIAPIGatewayIfDone : NSObject 
{
  CIAPIGatewayStopLimitOrder *Stop;
  CIAPIGatewayStopLimitOrder *Limit;
}

// The price at which the stop order will be filled
@property (retain) CIAPIGatewayStopLimitOrder *Stop;

// The price at which the limit order will be filled
@property (retain) CIAPIGatewayStopLimitOrder *Limit;

@end

