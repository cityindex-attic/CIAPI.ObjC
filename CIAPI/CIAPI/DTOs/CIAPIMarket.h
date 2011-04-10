// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//Information about a Market
@interface CIAPIMarket : NSObject<RKObjectMappable> 
{
  int MarketId;
  NSString *Name;
}

// A market's unique identifier
@property int MarketId;

// The market name
@property (retain) NSString *Name;

@end

