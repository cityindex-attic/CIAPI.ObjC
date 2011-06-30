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

- (BOOL)isEqual:(id)object
{
    // We can only compare against other object requests of our type
    if ([self isKindOfClass:[object class]])
        return NO;
    
    // Where the properties are identical
    return [[object propertiesForRequest] isEqualToDictionary:[self propertiesForRequest]];
}

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

- (NSTimeInterval)cacheDuration
{
    return 0.0;
}

- (Class)responseClass
{
    assert(FALSE);
    return nil;
}

@end