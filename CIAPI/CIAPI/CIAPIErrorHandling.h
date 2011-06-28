//
//  CIAPIErrorHandling.h
//  CIAPI
//
//  Created by Adam Wright on 28/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CIAPI_ERROR_DOMAIN @"CIAPI_ERROR"
#define CIAPI_ERROR_LOG @"CIAPI_ERROR_LOG"

enum CIAPIErrorCodes
{
    CIAPIErrorAuthenticationFailed,
    CIAPIErrorObjectSetup,
};
