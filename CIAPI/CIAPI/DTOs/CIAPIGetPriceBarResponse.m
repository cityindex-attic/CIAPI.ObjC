#import "CIAPIGetPriceBarResponse.h"

@implementation CIAPIGetPriceBarResponse

@synthesize PriceBars;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PriceBars" forKey:@"PriceBars"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIGetPriceBarResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"PriceBars" forKey:@"PriceBars"];

  return mappings;
}

@end
