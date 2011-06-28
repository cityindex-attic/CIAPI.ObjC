//
//  CIAPIObjectResponse.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIObjectResponse.h"

#import "ObjectPropertiesDictionaryMapper.h"

#import "CIAPILogging.h"

#import "CIAPIErrorHandling.h"

@implementation CIAPIObjectResponse

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error
{
    @try
    {
        CIAPILogAbout(CIAPILogLevelNote, CIAPIResponseParsingModule, self, @"Began scalar object setup from dictionary");
        [ObjectPropertiesDictionaryMapper dictionaryToObjectProperties:dictionary object:self];
    }
    @catch (NSException *exception)
    {
        CIAPILogAbout(CIAPILogLevelError, CIAPIResponseParsingModule, self, @"Could not setup scalar object from dictionary! Exception: %@", exception);
        
        // TODO: Real error handling
        if (error)
            *error = [NSError errorWithDomain:CIAPI_ERROR_DOMAIN code:CIAPIErrorObjectSetup userInfo:CIAPILogErrorDictForObject(self)];
        
        return FALSE;
    }
    
    return TRUE;
}

@end
