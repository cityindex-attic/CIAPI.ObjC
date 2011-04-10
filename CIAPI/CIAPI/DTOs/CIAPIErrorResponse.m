#import "CIAPIErrorResponse.h"

@implementation CIAPIErrorResponse

@synthesize ErrorMessage;
@synthesize ErrorCode;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ErrorMessage" forKey:@"ErrorMessage"];
  [mappings setValue:@"ErrorCode" forKey:@"ErrorCode"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIErrorResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ErrorMessage" forKey:@"ErrorMessage"];
  [mappings setValue:@"ErrorCode" forKey:@"ErrorCode"];

  return mappings;
}

@end
