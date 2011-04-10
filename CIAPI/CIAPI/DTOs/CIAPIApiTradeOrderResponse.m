#import "CIAPIApiTradeOrderResponse.h"

@implementation CIAPIApiTradeOrderResponse

@synthesize StatusReason;
@synthesize Status;
@synthesize OrderId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiTradeOrderResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

@end
