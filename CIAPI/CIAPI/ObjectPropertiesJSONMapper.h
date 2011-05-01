//
//  ObjectPropertiesJSONMapper.h
//  CIAPI
//
//  Created by Adam Wright on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectPropertiesJSONMapper : NSObject {
    
}

/** Determine all the properties declared on a class and it's superclasses (excluding NSObject)
 
 @param cls The class to search for properties
 @return An autoreleased array of NSString elements, describing the property names
 */
+ (NSArray*)classPropertyNames:(Class)cls;

@end
