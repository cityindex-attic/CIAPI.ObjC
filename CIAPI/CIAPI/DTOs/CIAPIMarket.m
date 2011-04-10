#import "CIAPIMarket.h"

@implementation CIAPIMarket

@synthesize MarketId;
@synthesize Name;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Name" forKey:@"Name"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIMarket alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Name" forKey:@"Name"];

  return mappings;
}

@end
