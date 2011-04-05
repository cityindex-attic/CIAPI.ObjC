// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPIGatewayOrder.h"


//Represents a stop/limit order
@interface CIAPIGatewayStopLimitOrder : CIAPIGatewayOrder
{
  NSString *ExpiryDateTimeUTC;
  NSString *Applicability;
}

// The associated expiry DateTime for a pair of GoodTillDate IfDone orders
@property (retain) NSString *ExpiryDateTimeUTC;

// Identifier which relates to the expiry of the order/trade, i.e. GoodTillDate (GTD), GoodTillCancelled (GTC) or GoodForDay (GFD)
@property (retain) NSString *Applicability;

@end

