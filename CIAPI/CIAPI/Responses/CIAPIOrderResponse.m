//
//  CIAPIOrderResponse.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIOrderResponse.h"

#import "CIAPIIfDoneResponse.h"


@implementation CIAPIOrderResponse 

@synthesize OrderId;
@synthesize StatusReason;
@synthesize Status;
@synthesize Price;
@synthesize CommissionCharge;
@synthesize IfDone;
@synthesize GuaranteedPremium;
@synthesize OCO;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"IfDone"]) return [CIAPIIfDoneResponse class];
  return nil;
}

@end

