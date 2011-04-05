// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//The response returned from the underlying trading system
@interface CIAPIApiTradeOrderResponse : NSObject 
{
  int StatusReason;
  int Status;
  int OrderId;
}

// The id corresponding to a more descriptive reason for the order status
@property int StatusReason;

// The status of the order (Pending, Accepted, Open, etc)
@property int Status;

// The unique identifier associated to the order returned from the underlying trading system
@property int OrderId;

@end

