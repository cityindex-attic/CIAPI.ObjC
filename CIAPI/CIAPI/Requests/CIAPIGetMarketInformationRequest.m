//
//  CIAPIGetMarketInformationRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGetMarketInformationRequest.h"

#import "CIAPIGetMarketInformationResponse.h"

@implementation CIAPIGetMarketInformationRequest

@synthesize marketId;



- (CIAPIGetMarketInformationRequest*)initWithMarketId:(NSString*)_marketId{
  self = [super init];

  if (self)
  {
    self.marketId = _marketId;
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
    return @"market/{marketId}/information";
}

- (Class)responseClass
{
    return [CIAPIGetMarketInformationResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

