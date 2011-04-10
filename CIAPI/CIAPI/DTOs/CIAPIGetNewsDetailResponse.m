#import "CIAPIGetNewsDetailResponse.h"

@implementation CIAPIGetNewsDetailResponse

@synthesize NewsDetail;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"NewsDetail" forKey:@"NewsDetail"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIGetNewsDetailResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"NewsDetail" forKey:@"NewsDetail"];

  return mappings;
}

@end
