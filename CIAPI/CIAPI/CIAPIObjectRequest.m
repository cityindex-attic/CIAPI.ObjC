//
//  CIAPIDataRequest.m
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIObjectRequest.h"
#import "ObjectPropertiesDictionaryMapper.h"


@implementation CIAPIObjectRequest

- (enum CIAPIRequestType)requestType
{
    assert(FALSE);
    return 0;
}

- (NSDictionary*)propertiesForRequest
{
    return [ObjectPropertiesDictionaryMapper objectPropertiesToDictionary:self];
}

- (NSString*)urlTemplate
{
    assert(FALSE);
    return nil;
}

- (NSString*)throttleScope
{
    return @"global";
}

- (Class)responseClass
{
    assert(FALSE);
    return nil;
}

@end