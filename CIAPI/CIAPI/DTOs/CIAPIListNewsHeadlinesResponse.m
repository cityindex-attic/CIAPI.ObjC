#import "CIAPIListNewsHeadlinesResponse.h"

@implementation CIAPIListNewsHeadlinesResponse

@synthesize Headlines;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Headlines" forKey:@"Headlines"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListNewsHeadlinesResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Headlines" forKey:@"Headlines"];

  return mappings;
}

@end
