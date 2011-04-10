#import "CIAPIApiTradeHistory.h"

@implementation CIAPIApiTradeHistory

@synthesize LastChangedDateTimeUtc;
@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize OriginalQuantity;
@synthesize Currency;
@synthesize Price;
@synthesize MarketName;
@synthesize OrderId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUtc" forKey:@"LastChangedDateTimeUtc"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiTradeHistory alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUtc" forKey:@"LastChangedDateTimeUtc"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

@end
