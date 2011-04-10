#import "CIAPIListCfdMarketsResponse.h"

@implementation CIAPIListCfdMarketsResponse

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

  return [[[CIAPIListCfdMarketsResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Markets" forKey:@"Markets"];

  return mappings;
}

@end
