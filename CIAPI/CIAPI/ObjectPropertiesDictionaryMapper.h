//
//  ObjectPropertiesJSONMapper.h
//  CIAPI
//
//  Created by Adam Wright on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectPropertiesDictionaryMapper : NSObject {
    
}


+ (NSDictionary*)objectPropertiesToDictionary:(id)obj;
+ (void)dictionaryToObjectProperties:(NSDictionary*)dict object:(id)obj;

/** Determine all the properties declared on a class and it's superclasses (excluding NSObject)
 
 @param cls The class to search for properties
 @return An autoreleased dictionary of NSString element keys, where the values are decoded property descriptions
 */
+ (NSDictionary*)classPropertyNames:(Class)cls;

@end
