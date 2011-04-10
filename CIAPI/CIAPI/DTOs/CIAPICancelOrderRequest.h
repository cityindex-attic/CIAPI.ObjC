// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//A cancel order request
@interface CIAPICancelOrderRequest : NSObject<RKObjectMappable> 
{
  int OrderId;
}

// The order identifier
@property int OrderId;

@end

