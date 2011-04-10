#import "CIAPICancelOrderRequest.h"

@implementation CIAPICancelOrderRequest

@synthesize OrderId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPICancelOrderRequest alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

@end
