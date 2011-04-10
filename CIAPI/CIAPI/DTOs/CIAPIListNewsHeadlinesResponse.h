// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//The response from a GET request for News headlines
@interface CIAPIListNewsHeadlinesResponse : NSObject<RKObjectMappable> 
{
  NSMutableArray *Headlines;
}

// A list of News headlines
@property (retain) NSMutableArray *Headlines;

@end

