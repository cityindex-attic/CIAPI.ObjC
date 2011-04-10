#import "CIAPISessionDeletionRequest.h"

@implementation CIAPISessionDeletionRequest


+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPISessionDeletionRequest alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];

  return mappings;
}

@end
