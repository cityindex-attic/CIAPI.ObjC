#import "CIAPIListTradeHistoryResponse.h"

@implementation CIAPIListTradeHistoryResponse

@synthesize TradeHistory;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradeHistory" forKey:@"TradeHistory"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIListTradeHistoryResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradeHistory" forKey:@"TradeHistory"];

  return mappings;
}

@end
