#import "CIAPINews.h"

@implementation CIAPINews

@synthesize PublishDate;
@synthesize Headline;
@synthesize StoryId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PublishDate" forKey:@"PublishDate"];
  [mappings setValue:@"Headline" forKey:@"Headline"];
  [mappings setValue:@"StoryId" forKey:@"StoryId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPINews alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PublishDate" forKey:@"PublishDate"];
  [mappings setValue:@"Headline" forKey:@"Headline"];
  [mappings setValue:@"StoryId" forKey:@"StoryId"];

  return mappings;
}

@end
