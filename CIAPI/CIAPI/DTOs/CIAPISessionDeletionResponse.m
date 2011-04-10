#import "CIAPISessionDeletionResponse.h"

@implementation CIAPISessionDeletionResponse

@synthesize LoggedOut;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LoggedOut" forKey:@"LoggedOut"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPISessionDeletionResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LoggedOut" forKey:@"LoggedOut"];

  return mappings;
}

@end
