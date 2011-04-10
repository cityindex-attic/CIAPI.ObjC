#import "CIAPIGatewayStopLimitOrder.h"

@implementation CIAPIGatewayStopLimitOrder

@synthesize ExpiryDateTimeUTC;
@synthesize Applicability;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ExpiryDateTimeUTC" forKey:@"ExpiryDateTimeUTC"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIGatewayStopLimitOrder alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ExpiryDateTimeUTC" forKey:@"ExpiryDateTimeUTC"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];

  return mappings;
}

@end
