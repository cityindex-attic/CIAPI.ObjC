#import "CIAPIPriceBar.h"

@implementation CIAPIPriceBar

@synthesize Open;
@synthesize BarDate;
@synthesize Close;
@synthesize High;
@synthesize Low;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Open" forKey:@"Open"];
  [mappings setValue:@"BarDate" forKey:@"BarDate"];
  [mappings setValue:@"Close" forKey:@"Close"];
  [mappings setValue:@"High" forKey:@"High"];
  [mappings setValue:@"Low" forKey:@"Low"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIPriceBar alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"Open" forKey:@"Open"];
  [mappings setValue:@"BarDate" forKey:@"BarDate"];
  [mappings setValue:@"Close" forKey:@"Close"];
  [mappings setValue:@"High" forKey:@"High"];
  [mappings setValue:@"Low" forKey:@"Low"];

  return mappings;
}

@end
