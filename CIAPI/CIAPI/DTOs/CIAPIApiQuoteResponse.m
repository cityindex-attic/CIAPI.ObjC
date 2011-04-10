#import "CIAPIApiQuoteResponse.h"

@implementation CIAPIApiQuoteResponse

@synthesize StatusReason;
@synthesize Status;
@synthesize QuoteId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"QuoteId" forKey:@"QuoteId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiQuoteResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"QuoteId" forKey:@"QuoteId"];

  return mappings;
}

@end
