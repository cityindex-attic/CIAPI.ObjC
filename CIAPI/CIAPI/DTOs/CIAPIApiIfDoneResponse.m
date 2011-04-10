#import "CIAPIApiIfDoneResponse.h"

@implementation CIAPIApiIfDoneResponse

@synthesize Stop;
@synthesize Limit;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Stop" forKey:@"Stop"];
  [mappings setValue:@"Limit" forKey:@"Limit"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiIfDoneResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Stop" forKey:@"Stop"];
  [mappings setValue:@"Limit" forKey:@"Limit"];

  return mappings;
}

@end
