#import "CIAPIPriceTick.h"

@implementation CIAPIPriceTick

@synthesize TickDate;
@synthesize Price;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TickDate" forKey:@"TickDate"];
  [mappings setValue:@"Price" forKey:@"Price"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIPriceTick alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TickDate" forKey:@"TickDate"];
  [mappings setValue:@"Price" forKey:@"Price"];

  return mappings;
}

@end
