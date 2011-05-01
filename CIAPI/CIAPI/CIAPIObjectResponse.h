//
//  CIAPIObjectResponse.h
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CIAPIObjectResponse : NSObject {
    
}

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error;

@end
