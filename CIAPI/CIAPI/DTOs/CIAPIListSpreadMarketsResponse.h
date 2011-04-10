// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//Contains the result of a ListSpreadMarketsResponseDTO query
@interface CIAPIListSpreadMarketsResponse : NSObject<RKObjectMappable> 
{
  NSMutableArray *Markets;
}

// A list of Spread Betting markets
@property (retain) NSMutableArray *Markets;

@end

