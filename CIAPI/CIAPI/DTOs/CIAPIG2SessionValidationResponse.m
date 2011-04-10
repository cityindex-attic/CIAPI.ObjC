#import "CIAPIG2SessionValidationResponse.h"

@implementation CIAPIG2SessionValidationResponse

@synthesize ClientAccountIds;
@synthesize TradingAccountIds;
@synthesize IsValid;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ClientAccountIds" forKey:@"ClientAccountIds"];
  [mappings setValue:@"TradingAccountIds" forKey:@"TradingAccountIds"];
  [mappings setValue:@"IsValid" forKey:@"IsValid"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIG2SessionValidationResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"ClientAccountIds" forKey:@"ClientAccountIds"];
  [mappings setValue:@"TradingAccountIds" forKey:@"TradingAccountIds"];
  [mappings setValue:@"IsValid" forKey:@"IsValid"];

  return mappings;
}

@end
