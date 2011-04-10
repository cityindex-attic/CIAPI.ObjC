#import "CIAPIListOpenPositionsResponse.h"

@implementation CIAPIListOpenPositionsResponse

@synthesize OpenPositions;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OpenPositions" forKey:@"OpenPositions"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListOpenPositionsResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OpenPositions" forKey:@"OpenPositions"];

  return mappings;
}

@end
