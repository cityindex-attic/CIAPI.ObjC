#import "CIAPINewStopLimitOrderRequest.h"

@implementation CIAPINewStopLimitOrderRequest

@synthesize TradingAccountId;
@synthesize Direction;
@synthesize MarketId;
@synthesize ExpiryDateTimeUTC;
@synthesize AuditId;
@synthesize Quantity;
@synthesize BidPrice;
@synthesize OfferPrice;
@synthesize Applicability;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"ExpiryDateTimeUTC" forKey:@"ExpiryDateTimeUTC"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPINewStopLimitOrderRequest alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"TradingAccountId" forKey:@"TradingAccountId"];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"ExpiryDateTimeUTC" forKey:@"ExpiryDateTimeUTC"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];
  [mappings setValue:@"Applicability" forKey:@"Applicability"];

  return mappings;
}

@end
