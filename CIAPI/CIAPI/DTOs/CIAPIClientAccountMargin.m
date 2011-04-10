#import "CIAPIClientAccountMargin.h"

@implementation CIAPIClientAccountMargin

@synthesize OpenTradeEquity;
@synthesize CurrencyId;
@synthesize PendingFunds;
@synthesize CurrencyISO;
@synthesize NetEquity;
@synthesize MarginIndicator;
@synthesize TradeableFunds;
@synthesize Margin;
@synthesize TotalMarginRequirement;
@synthesize TradingResource;
@synthesize Cash;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OpenTradeEquity" forKey:@"OpenTradeEquity"];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"PendingFunds" forKey:@"PendingFunds"];
  [mappings setValue:@"CurrencyISO" forKey:@"CurrencyISO"];
  [mappings setValue:@"NetEquity" forKey:@"NetEquity"];
  [mappings setValue:@"MarginIndicator" forKey:@"MarginIndicator"];
  [mappings setValue:@"TradeableFunds" forKey:@"TradeableFunds"];
  [mappings setValue:@"Margin" forKey:@"Margin"];
  [mappings setValue:@"TotalMarginRequirement" forKey:@"TotalMarginRequirement"];
  [mappings setValue:@"TradingResource" forKey:@"TradingResource"];
  [mappings setValue:@"Cash" forKey:@"Cash"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIClientAccountMargin alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"OpenTradeEquity" forKey:@"OpenTradeEquity"];
  [mappings setValue:@"CurrencyId" forKey:@"CurrencyId"];
  [mappings setValue:@"PendingFunds" forKey:@"PendingFunds"];
  [mappings setValue:@"CurrencyISO" forKey:@"CurrencyISO"];
  [mappings setValue:@"NetEquity" forKey:@"NetEquity"];
  [mappings setValue:@"MarginIndicator" forKey:@"MarginIndicator"];
  [mappings setValue:@"TradeableFunds" forKey:@"TradeableFunds"];
  [mappings setValue:@"Margin" forKey:@"Margin"];
  [mappings setValue:@"TotalMarginRequirement" forKey:@"TotalMarginRequirement"];
  [mappings setValue:@"TradingResource" forKey:@"TradingResource"];
  [mappings setValue:@"Cash" forKey:@"Cash"];

  return mappings;
}

@end
