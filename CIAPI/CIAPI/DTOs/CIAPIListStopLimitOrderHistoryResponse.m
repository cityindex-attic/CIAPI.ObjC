#import "CIAPIListStopLimitOrderHistoryResponse.h"

@implementation CIAPIListStopLimitOrderHistoryResponse

@synthesize StopLimitOrderHistory;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StopLimitOrderHistory" forKey:@"StopLimitOrderHistory"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListStopLimitOrderHistoryResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StopLimitOrderHistory" forKey:@"StopLimitOrderHistory"];

  return mappings;
}

@end
