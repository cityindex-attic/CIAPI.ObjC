//
//  CIAPIDataRequest.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIRequestDelegate.h"

@class CIAPIRequestToken;

typedef void(^CIAPIRequestCallback)(CIAPIRequestToken *request, id response, NSError *error);

enum CIAPIRequestType
{
    CIAPIRequestGET,
    CIAPIRequestPOST,
};

@interface CIAPIObjectRequest : NSObject {
    enum CIAPIRequestType requestType;
}

- (enum CIAPIRequestType)requestType;
- (NSDictionary*)propertiesForRequest;
- (NSString*)urlTemplate;
- (NSString*)throttleScope;
- (NSTimeInterval)cacheDuration;
- (Class)responseClass;

@end
