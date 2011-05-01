//
//  CIAPIDataRequest.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIRequestDelegate.h"
#import "RestKit/RestKit.h"

typedef void(^CIAPIRequestCallback)(id request, id response, NSError *error);

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
- (Class)responseClass;

@end
