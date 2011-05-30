//
//  CIAPIClientAccountWatchlist.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIClientAccountWatchlist.h"

#import "CIAPIClientAccountWatchlistItem.h"


@implementation CIAPIClientAccountWatchlist 

@synthesize WatchlistId;
@synthesize WatchlistDescription;
@synthesize DisplayOrder;
@synthesize Items;

- (Class)propertyTypeHintForName:(NSString*)name
{
  if ([name isEqualToString:@"Items"]) return [CIAPIClientAccountWatchlistItem class];
  return nil;
}

@end

