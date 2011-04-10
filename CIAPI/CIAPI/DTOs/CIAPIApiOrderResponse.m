#import "CIAPIApiOrderResponse.h"

@implementation CIAPIApiOrderResponse

@synthesize CommissionCharge;
@synthesize Status;
@synthesize StatusReason;
@synthesize IfDone;
@synthesize Price;
@synthesize OrderId;

+ (NSDictionary*)elementToPropertyMappings
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"CommissionCharge" forKey:@"CommissionCharge"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"IfDone" forKey:@"IfDone"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

+ (NSDictionary*)elementToRelationshipMappings
{
  return [NSMutableDictionary dictionary];
}

+ (id)object
{

  return [[[CIAPIApiOrderResponse alloc] init] autorelease];
}

- (NSDictionary*)propertiesForSerialization
{
  NSMutableDictionary *mappings = [NSMutableDictionary dictionary];
  [mappings setValue:@"CommissionCharge" forKey:@"CommissionCharge"];
  [mappings setValue:@"Status" forKey:@"Status"];
  [mappings setValue:@"StatusReason" forKey:@"StatusReason"];
  [mappings setValue:@"IfDone" forKey:@"IfDone"];
  [mappings setValue:@"Price" forKey:@"Price"];
  [mappings setValue:@"OrderId" forKey:@"OrderId"];

  return mappings;
}

@end
