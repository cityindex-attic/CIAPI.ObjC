#import "CIAPIApiOpenPosition.h"

@implementation CIAPIApiOpenPosition

@synthesize LastChangedDateTimeUTC;
@synthesize Status;
@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize Quantity;
@synthesize StopOrder;
@synthesize Currency;
@synthesize Price;
@synthesize MarketName;
@synthesize OrderId;
@synthesize LimitOrder;

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
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"LimitOrder" forKey:@"LimitOrder"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiOpenPosition alloc] init] autorelease];
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
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"LimitOrder" forKey:@"LimitOrder"];

  return mappings;
}

@end
