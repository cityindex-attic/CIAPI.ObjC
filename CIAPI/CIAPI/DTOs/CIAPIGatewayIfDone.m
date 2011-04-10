#import "CIAPIGatewayIfDone.h"

@implementation CIAPIGatewayIfDone

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

  return [[[CIAPIGatewayIfDone alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Stop" forKey:@"Stop"];
  [mappings setValue:@"Limit" forKey:@"Limit"];

  return mappings;
}

@end
