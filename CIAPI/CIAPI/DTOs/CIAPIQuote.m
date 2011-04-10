#import "CIAPIQuote.h"

@implementation CIAPIQuote

@synthesize CurrencyId;
@synthesize MarketId;
@synthesize Quantity;
@synthesize RequestDateTime;
@synthesize TypeId;
@synthesize BidAdjust;
@synthesize BidPrice;
@synthesize QuoteId;
@synthesize StatusId;
@synthesize OfferAdjust;
@synthesize OfferPrice;
@synthesize OrderId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"RequestDateTime" forKey:@"RequestDateTime"];
  [mappings setValue:@"TypeId" forKey:@"TypeId"];
  [mappings setValue:@"BidAdjust" forKey:@"BidAdjust"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"QuoteId" forKey:@"QuoteId"];
  [mappings setValue:@"StatusId" forKey:@"StatusId"];
  [mappings setValue:@"OfferAdjust" forKey:@"OfferAdjust"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIQuote alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"Quantity" forKey:@"Quantity"];
  [mappings setValue:@"RequestDateTime" forKey:@"RequestDateTime"];
  [mappings setValue:@"TypeId" forKey:@"TypeId"];
  [mappings setValue:@"BidAdjust" forKey:@"BidAdjust"];
  [mappings setValue:@"BidPrice" forKey:@"BidPrice"];
  [mappings setValue:@"QuoteId" forKey:@"QuoteId"];
  [mappings setValue:@"StatusId" forKey:@"StatusId"];
  [mappings setValue:@"OfferAdjust" forKey:@"OfferAdjust"];
  [mappings setValue:@"OfferPrice" forKey:@"OfferPrice"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

@end
