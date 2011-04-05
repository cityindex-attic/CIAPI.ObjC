// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//Information about a Market
@interface CIAPIMarket : NSObject 
{
  int MarketId;
  NSString *Name;
}

// A market's unique identifier
@property int MarketId;

// The market name
@property (retain) NSString *Name;

@end

