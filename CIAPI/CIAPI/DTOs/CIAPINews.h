// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//A news headline
@interface CIAPINews : NSObject 
{
  NSString *PublishDate;
  NSString *Headline;
  int StoryId;
}

// The date on which the news story was published. Always in UTC
@property (retain) NSString *PublishDate;

// The News story headline
@property (retain) NSString *Headline;

// The unique identifier for a news story
@property int StoryId;

@end

