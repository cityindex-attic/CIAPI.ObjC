#import "CIAPILogOnRequest.h"

@implementation CIAPILogOnRequest

@synthesize UserName;
@synthesize Password;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"UserName" forKey:@"UserName"];
  [mappings setValue:@"Password" forKey:@"Password"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPILogOnRequest alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:self.UserName forKey:@"UserName"];
    [mappings setValue:self.Password forKey:@"Password"];

  return mappings;
}

@end
