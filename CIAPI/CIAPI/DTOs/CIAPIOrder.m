#import "CIAPIOrder.h"

@implementation CIAPIOrder

@synthesize Status;
@synthesize OpenPrice;
@synthesize LastChangedTime;
@synthesize Direction;
@synthesize TradingAccountId;
@synthesize CurrencyId;
@synthesize MarketId;
@synthesize Quantity;
@synthesize AutoRollover;
@synthesize CurrencyISO;
@synthesize OriginalQuantity;
@synthesize ExecutionPrice;
@synthesize ReasonId;
@synthesize ClientAccountId;
@synthesize OrderId;
@synthesize Type;
@synthesize OriginalLastChangedDateTime;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"OpenPrice" forKey:@"OpenPrice"];
  [mappings setValue:@"LastChangedTime" forKey:@"LastChangedTime"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"AutoRollover" forKey:@"AutoRollover"];
  [mappings setValue:@"CurrencyISO" forKey:@"CurrencyISO"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"ExecutionPrice" forKey:@"ExecutionPrice"];
  [mappings setValue:@"ReasonId" forKey:@"ReasonId"];
  [mappings setValue:@"ClientAccountId" forKey:@"ClientAccountId"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"Type" forKey:@"Type"];
  [mappings setValue:@"OriginalLastChangedDateTime" forKey:@"OriginalLastChangedDateTime"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIOrder alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"OpenPrice" forKey:@"OpenPrice"];
  [mappings setValue:@"LastChangedTime" forKey:@"LastChangedTime"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"AutoRollover" forKey:@"AutoRollover"];
  [mappings setValue:@"CurrencyISO" forKey:@"CurrencyISO"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"ExecutionPrice" forKey:@"ExecutionPrice"];
  [mappings setValue:@"ReasonId" forKey:@"ReasonId"];
  [mappings setValue:@"ClientAccountId" forKey:@"ClientAccountId"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"Type" forKey:@"Type"];
  [mappings setValue:@"OriginalLastChangedDateTime" forKey:@"OriginalLastChangedDateTime"];

  return mappings;
}

@end
