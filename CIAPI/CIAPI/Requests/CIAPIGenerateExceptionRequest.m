//
//  CIAPIGenerateExceptionRequest.m
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import "CIAPIGenerateExceptionRequest.h"

#import "CIAPIErrorResponse.h"

@implementation CIAPIGenerateExceptionRequest

@synthesize errorCode;



- (CIAPIGenerateExceptionRequest*)initWithErrorCode:(NSInteger)_errorCode{
  self = [super init];

  if (self)
  {
    self.errorCode = _errorCode;
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
    return @"errors?errorCode={errorCode}";
}

- (Class)responseClass
{
    return [CIAPIErrorResponse class];
}

- (NSString*)throttleScope
{
    return @"data";
}


@end

