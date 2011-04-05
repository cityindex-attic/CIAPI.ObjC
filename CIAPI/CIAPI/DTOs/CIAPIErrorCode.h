//
//  CIAPIErrorCode.h
//  CIAPI
//
//  Created by Adam Wright on 05/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CIAPIErrorCode
{
    CIAPIErrorForbidden = 403,
    CIAPIErrorInternalServerError = 500,
    CIAPIErrorInvalidParameterType = 4000,
    CIAPIErrorParameterMissing = 4001,
    CIAPIErrorInvalidParameterValue = 4002,
    CIAPIErrorInvalidJsonRequest = 4003,
    CIAPIErrorInvalidJsonRequestCaseFormat = 4004,
    // The credentials used to authenticate are invalid.  Either the username, password or both are incorrect
    CIAPIErrorInvalidCredentials = 4010
};


