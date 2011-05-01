//
//  ObjectPropertiesJSONMapper.m
//  CIAPI
//
//  Created by Adam Wright on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "ObjectPropertiesJSONMapper.h"


@implementation ObjectPropertiesJSONMapper

- (NSDictionary*)objectPropertiesToDictionary:(NSObject*)obj
{
    return nil;
}

// Return an autoreleased array of the properties of object, recursing up the parent chain
+ (NSArray*)classPropertyNames:(Class)cls
{
    unsigned int propCount;
    objc_property_t *propArray = class_copyPropertyList(cls, &propCount);

    NSMutableArray *properties = [NSMutableArray arrayWithCapacity:propCount];
    
    if (propCount > 0)
    {
        for (int i = 0; i < propCount; i++)
        {
            const char *propName = property_getName(propArray[i]);
            [properties addObject:[NSString stringWithCString:propName encoding:NSASCIIStringEncoding]];
        }
        
        free(propArray);
    }
    
    if ([cls superclass] != [NSObject class])
        [properties addObjectsFromArray:[ObjectPropertiesJSONMapper classPropertyNames:[cls superclass]]];
    
    return properties;
}

@end
