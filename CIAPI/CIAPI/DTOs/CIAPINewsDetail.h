// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "CIAPINews.h"

//Contains details of a specific news story
@interface CIAPINewsDetail : CIAPINews
{
  NSString *Story;
}

// The detail of the story. This can contain HTML characters.
@property (retain) NSString *Story;

@end

