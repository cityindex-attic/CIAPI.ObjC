#import "CIAPIPrice.h"

@implementation CIAPIPrice

@synthesize Direction;
@synthesize MarketId;
@synthesize AuditId;
@synthesize High;
@synthesize TickDate;
@synthesize Change;
@synthesize Bid;
@synthesize Offer;
@synthesize Low;
@synthesize Price;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"High" forKey:@"High"];
  [mappings setValue:@"TickDate" forKey:@"TickDate"];
  [mappings setValue:@"Change" forKey:@"Change"];
  [mappings setValue:@"Bid" forKey:@"Bid"];
  [mappings setValue:@"Offer" forKey:@"Offer"];
  [mappings setValue:@"Low" forKey:@"Low"];
  [mappings setValue:@"Price" forKey:@"Price"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIPrice alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Direction" forKey:@"Direction"];
  [mappings setValue:@"MarketId" forKey:@"MarketId"];
  [mappings setValue:@"AuditId" forKey:@"AuditId"];
  [mappings setValue:@"High" forKey:@"High"];
  [mappings setValue:@"TickDate" forKey:@"TickDate"];
  [mappings setValue:@"Change" forKey:@"Change"];
  [mappings setValue:@"Bid" forKey:@"Bid"];
  [mappings setValue:@"Offer" forKey:@"Offer"];
  [mappings setValue:@"Low" forKey:@"Low"];
  [mappings setValue:@"Price" forKey:@"Price"];

  return mappings;
}

@end
