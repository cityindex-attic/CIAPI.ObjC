#import "CIAPIApiBasicStopLimitOrder.h"

@implementation CIAPIApiBasicStopLimitOrder

@synthesize OrderId;
@synthesize TriggerPrice;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiBasicStopLimitOrder alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

@end
