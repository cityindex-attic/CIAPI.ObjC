#import "CIAPIApiActiveStopLimitOrder.h"

@implementation CIAPIApiActiveStopLimitOrder

@synthesize LastChangedDateTimeUTC;
@synthesize Status;
@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize Quantity;
@synthesize StopOrder;
@synthesize Applicability;
@synthesize Currency;
@synthesize MarketName;
@synthesize OrderId;
@synthesize OcoOrder;
@synthesize LimitOrder;
@synthesize Type;
@synthesize TriggerPrice;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUTC" forKey:@"LastChangedDateTimeUTC"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"StopOrder" forKey:@"StopOrder"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"OcoOrder" forKey:@"OcoOrder"];
  [mappings setValue:@"LimitOrder" forKey:@"LimitOrder"];
  [mappings setValue:@"Type" forKey:@"Type"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiActiveStopLimitOrder alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUTC" forKey:@"LastChangedDateTimeUTC"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"StopOrder" forKey:@"StopOrder"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"OcoOrder" forKey:@"OcoOrder"];
  [mappings setValue:@"LimitOrder" forKey:@"LimitOrder"];
  [mappings setValue:@"Type" forKey:@"Type"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

@end
