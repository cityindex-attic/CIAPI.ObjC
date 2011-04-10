#import "CIAPINewTradeOrderRequest.h"

@implementation CIAPINewTradeOrderRequest

@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize AuditId;
@synthesize Quantity;
@synthesize BidPrice;
@synthesize OfferPrice;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPINewTradeOrderRequest alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];

  return mappings;
}

@end
