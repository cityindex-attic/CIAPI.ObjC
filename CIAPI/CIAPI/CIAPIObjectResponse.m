//
//  CIAPIObjectResponse.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIObjectResponse.h"

#import "ObjectPropertiesDictionaryMapper.h"


@implementation CIAPIObjectResponse

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error
{
    @try
    {
        [ObjectPropertiesDictionaryMapper dictionaryToObjectProperties:dictionary object:self];
    }
    @catch (NSException *exception)
    {
        // TODO: Real error handling
        if (error)
            *error = [NSError errorWithDomain:@"Cannot decode" code:0 userInfo:[NSDictionary dictionaryWithObject:exception forKey:@"exception"]];
        
        return FALSE;
    }
    
    return TRUE;
}

@end
