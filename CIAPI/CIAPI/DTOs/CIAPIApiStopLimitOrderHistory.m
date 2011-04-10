#import "CIAPIApiStopLimitOrderHistory.h"

@implementation CIAPIApiStopLimitOrderHistory

@synthesize LastChangedDateTimeUtc;
@synthesize OrderApplicabilityId;
@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize TypeId;
@synthesize StatusId;
@synthesize OriginalQuantity;
@synthesize Currency;
@synthesize Price;
@synthesize MarketName;
@synthesize OrderId;
@synthesize TriggerPrice;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUtc" forKey:@"LastChangedDateTimeUtc"];
  [mappings setValue:@"OrderApplicabilityId" forKey:@"OrderApplicabilityId"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"TypeId" forKey:@"TypeId"];
  [mappings setValue:@"StatusId" forKey:@"StatusId"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiStopLimitOrderHistory alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"LastChangedDateTimeUtc" forKey:@"LastChangedDateTimeUtc"];
  [mappings setValue:@"OrderApplicabilityId" forKey:@"OrderApplicabilityId"];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"TypeId" forKey:@"TypeId"];
  [mappings setValue:@"StatusId" forKey:@"StatusId"];
  [mappings setValue:@"OriginalQuantity" forKey:@"OriginalQuantity"];
  [mappings setValue:@"Currency" forKey:@"Currency"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"MarketName" forKey:@"MarketName"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];
  [mappings setValue:@"TriggerPrice" forKey:@"TriggerPrice"];

  return mappings;
}

@end
