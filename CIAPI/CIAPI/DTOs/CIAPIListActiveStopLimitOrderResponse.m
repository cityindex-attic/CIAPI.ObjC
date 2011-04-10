#import "CIAPIListActiveStopLimitOrderResponse.h"

@implementation CIAPIListActiveStopLimitOrderResponse

@synthesize ActiveStopLimitOrders;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ActiveStopLimitOrders" forKey:@"ActiveStopLimitOrders"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListActiveStopLimitOrderResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ActiveStopLimitOrders" forKey:@"ActiveStopLimitOrders"];

  return mappings;
}

@end
