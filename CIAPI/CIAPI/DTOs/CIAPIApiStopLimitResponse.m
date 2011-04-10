#import "CIAPIApiStopLimitResponse.h"

@implementation CIAPIApiStopLimitResponse

@synthesize GuaranteedPremium;
@synthesize OCO;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"GuaranteedPremium" forKey:@"GuaranteedPremium"];
  [mappings setValue:@"OCO" forKey:@"OCO"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiStopLimitResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"GuaranteedPremium" forKey:@"GuaranteedPremium"];
  [mappings setValue:@"OCO" forKey:@"OCO"];

  return mappings;
}

@end
