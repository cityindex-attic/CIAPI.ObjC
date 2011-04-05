// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPINews.h"

//Contains details of a specific news story
@interface CIAPINewsDetail : CIAPINews 
{
  NSString *Story;
}

// The detail of the story. This can contain HTML characters.
@property (retain) NSString *Story;

@end

