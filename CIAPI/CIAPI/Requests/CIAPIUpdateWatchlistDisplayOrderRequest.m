//
//  CIAPIUpdateWatchlistDisplayOrderRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIUpdateWatchlistDisplayOrderRequest.h"



@implementation CIAPIUpdateWatchlistDisplayOrderRequest 

@synthesize NewDisplayOrderIdSequence;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"NewDisplayOrderIdSequence"]) return [NSNumber class];
  return nil;
}

@end

