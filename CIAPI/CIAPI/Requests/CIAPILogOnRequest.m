//
//  CIAPILogOnRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPILogOnRequest.h"

#import "CIAPILogOnResponse.h"

@implementation CIAPILogOnRequest

@synthesize UserName;
@synthesize Password;



- (CIAPILogOnRequest*)initWithUserName:(NSString*)_UserName password:(NSString*)_Password{
  self = [super init];

  if (self)
  {
    self.UserName = _UserName;
    self.Password = _Password;
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
    return @"session/";
}

- (Class)responseClass
{
    return [CIAPILogOnResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

