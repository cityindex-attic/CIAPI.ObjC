#import "CIAPIGetPriceTickResponse.h"

@implementation CIAPIGetPriceTickResponse

@synthesize PriceTicks;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PriceTicks" forKey:@"PriceTicks"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIGetPriceTickResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PriceTicks" forKey:@"PriceTicks"];

  return mappings;
}

@end
