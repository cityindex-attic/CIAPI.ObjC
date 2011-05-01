//
//  CIAPIObjectListResponse.h
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIObjectListResponse : CIAPIObjectResponse<NSFastEnumeration> {
    NSArray *array;
}

@property (readonly) NSArray *array;

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error;

- (Class)contentsClass;

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;

@end
