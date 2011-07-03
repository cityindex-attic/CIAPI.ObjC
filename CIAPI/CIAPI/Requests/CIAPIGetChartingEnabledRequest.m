//
//  CIAPIGetChartingEnabledRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetChartingEnabledRequest.h"


@implementation CIAPIGetChartingEnabledRequest

@synthesize ident;



- (CIAPIGetChartingEnabledRequest*)initWithIdent:(NSString*)_ident{
  self = [super init];

  if (self)
  {
    self.ident = _ident;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestGET;
}

- (NSString*)urlTemplate
{
    return @"useraccount/UserAccount/{id}/ChartingEnabled";
}

- (Class)responseClass
{
    return [NSNumber class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

