//
//  CIAPIDeleteSessionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIDeleteSessionRequest.h"

#import "CIAPILogOffResponse.h"

@implementation CIAPIDeleteSessionRequest

@synthesize userName;
@synthesize session;



- (CIAPIDeleteSessionRequest*)initWithUserName:(NSString*)_userName session:(NSString*)_session{
  self = [super init];

  if (self)
  {
    self.userName = _userName;
    self.session = _session;
  }

  return self;
}

// If we have array parameters, vend the array types from a function for
// automatic object construction

- (enum CIAPIRequestType)requestType
{
    return CIAPIRequestPOST;
}

- (NSString*)urlTemplate
{
    return @"session/deleteSession?userName={userName}&session={session}";
}

- (Class)responseClass
{
    return [CIAPILogOffResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

