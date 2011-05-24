//
//  ObjectPropertiesJSONMapper.m
//  CIAPI
//
//  Created by Adam Wright on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "ObjectPropertiesDictionaryMapper.h"
#import "PropertyDescriptionDecoder.h"

@implementation ObjectPropertiesDictionaryMapper

+ (void)dictionaryToObjectProperties:(NSDictionary*)dict object:(id)obj
{
    NSDictionary *properties = [self classPropertyNames:[obj class]];
    
    for (NSString *key in dict)
    { 
        PropertyDescriptionDecoder *propDesc = [properties objectForKey:key];
        if (propDesc == nil)
            @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The dictionary has entries for which there is no object property" userInfo:nil];

        // If we're decoding into an object...
        if ([propDesc.propertyType isNonStringObject])
        {
            id subDict = [dict objectForKey:key];
            
            // We must have a dictionary to decode into it
            if ([[subDict class] isSubclassOfClass:[NSDictionary class]])
            {
                id subObj = [obj valueForKey:key];
                
                // If we don't yet have the target object, try and create an instance from the type
                if (subObj == nil)
                {
                    Class subObjClass = NSClassFromString(propDesc.propertyType.objectClassName);
                    
                    if (subObjClass == nil)
                        @throw [NSException exceptionWithName:@"CannotDecode" reason:@"A needed subobject was nil, and it's type could not be found" userInfo:nil];
                    
                    subObj = [[subObjClass alloc] init];
                    
                    if (subObj == nil)
                        @throw [NSException exceptionWithName:@"CannotDecode" reason:@"A needed subobject was nil, and it's type could not be constructed" userInfo:nil];
                    
                    [obj setValue:subObj forKey:key];
                }
                
                // Recursively decode into the sub object
                [self dictionaryToObjectProperties:subDict object:subObj];
            }
            else
            {
                @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The dictionary has entries of a non-dictionary type for which the object has a subobject" userInfo:nil];
            }       
        }
        // Anything non-object that we know is OK, let KVC handle
        else if ([propDesc.propertyType isBoolean] || [propDesc.propertyType isNumeric] || [propDesc.propertyType isString])
        {
            [obj setValue:[dict objectForKey:key] forKey:key];
        }
        else
        {
            @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The object has properties outside of the decodable set" userInfo:nil];
        }
        
    }
}

+ (NSDictionary*)objectPropertiesToDictionary:(id)obj
{
    NSDictionary *properties = [self classPropertyNames:[obj class]];
    NSMutableDictionary *mappingResult = [NSMutableDictionary dictionaryWithCapacity:[properties count]];
    
    for (NSString *property in properties)
    {
        PropertyDescriptionDecoder *propDesc = [properties objectForKey:property];
        
        // Need to check how much of this happens automatically with KVC
        if ([propDesc.propertyType isNonStringObject])
        {
            id subObject = [obj valueForKey:property];
            [mappingResult setObject:[self objectPropertiesToDictionary:subObject] forKey:property];
        }
        else if ([propDesc.propertyType isBoolean])
        {
            NSNumber *r = [obj valueForKey:property];
            [mappingResult setObject:([r boolValue] ? @"true" : @"false") forKey:property];
        }
        else if ([propDesc.propertyType isNumeric] || [propDesc.propertyType isString])
        {
            [mappingResult setObject:[obj valueForKey:property] forKey:property];
        }
        else
        {
            @throw [NSException exceptionWithName:@"CannotEncode" reason:@"The object has properties outside of the encodable set" userInfo:nil];
        }
            
    }
    
    return mappingResult;
}

// Return an autoreleased array of the properties of object, recursing up the parent chain
+ (NSDictionary*)classPropertyNames:(Class)cls
{
    unsigned int propCount;
    objc_property_t *propArray = class_copyPropertyList(cls, &propCount);

    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithCapacity:propCount];
    
    if (propCount > 0)
    {
        for (int i = 0; i < propCount; i++)
        {
            const char *propName = property_getName(propArray[i]);
            const char *propType = property_getAttributes(propArray[i]);
            
            PropertyDescriptionDecoder *propDecoded = [PropertyDescriptionDecoder propertyDescriptionByDecodingString:propType];
            NSString *propNameString = [NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
            
            [properties setObject:propDecoded forKey:propNameString];
        }
        
        free(propArray);
    }
    
    if ([cls superclass] != [NSObject class])
        [properties addEntriesFromDictionary:[ObjectPropertiesDictionaryMapper classPropertyNames:[cls superclass]]];
    
    return properties;
}

@end
