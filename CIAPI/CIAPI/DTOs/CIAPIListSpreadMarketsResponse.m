#import "CIAPIListSpreadMarketsResponse.h"

@implementation CIAPIListSpreadMarketsResponse

@synthesize Markets;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Markets" forKey:@"Markets"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListSpreadMarketsResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Markets" forKey:@"Markets"];

  return mappings;
}

@end
