//
//  ObjectPropertiesJSONMapper.m
//  CIAPI
//
//  Created by Adam Wright on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "ObjectPropertiesDictionaryMapper.h"

@implementation ObjectPropertiesDictionaryMapper

+ (void)dictionaryToObjectProperties:(NSDictionary*)dict object:(id)targetObject
{
    NSDictionary *objProperties = [self classPropertyNames:[targetObject class]];
    
    // For every property in the source dictionary (in general, JSON)...
    for (NSString *currentProperty in dict)
    {
        // Find the associated property in the target object and decode into it (or fail if there is no correctly named property)
        PropertyDescriptionDecoder *currentPropertyDesc = [objProperties objectForKey:currentProperty];
        if (currentPropertyDesc == nil)
            @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The dictionary has entries for which there is no object property" userInfo:nil];

        [self decodeObject:[dict objectForKey:currentProperty] intoObject:targetObject property:currentProperty describedBy:currentPropertyDesc];
    }
}

+ (void)decodeObject:(id)sourceObject intoObject:(id)targetObject property:(NSString*)objectPropertyName describedBy:(PropertyDescriptionDecoder*)propertyDesc
{
    // If we're decoding into an object...
    if ([propertyDesc.propertyType isNonStringObject])
    {        
        // If we're trying to decode a dictionary, then we're going to be creating or reusing an object in the target object
        if ([[sourceObject class] isSubclassOfClass:[NSDictionary class]])
        {
            id targetObjectFieldContents = [targetObject valueForKey:objectPropertyName];
            
            // If we don't yet have the target object, try and create an instance from the type
            if (targetObjectFieldContents == nil)
            {
                Class targetPropertyClass = NSClassFromString(propertyDesc.propertyType.objectClassName);
                
                if (targetPropertyClass == nil)
                {
                    @throw [NSException exceptionWithName:@"CannotDecode" reason:@"A needed target object property was nil, and it's type could not be found"
                                                 userInfo:nil];
                }
                
                targetObjectFieldContents = [[targetPropertyClass alloc] init];
                
                if (targetObjectFieldContents == nil)
                {
                    @throw [NSException exceptionWithName:@"CannotDecode" reason:@"A needed target object property was nil, and it's type could not be constructed"
                                                 userInfo:nil];
                }
                
                [targetObject setValue:targetObjectFieldContents forKey:objectPropertyName];
            }
            
            // Recursively decode into the sub object
            [self dictionaryToObjectProperties:sourceObject object:targetObjectFieldContents];
        }
        else if ([[sourceObject class] isSubclassOfClass:[NSArray class]])
        {
            // If we're trying to decode an array, we'll need type hints for the contents from the target object
            NSMutableArray *newObjects = [NSMutableArray array];
            Class objectType = nil;
            
            if ([targetObject respondsToSelector:@selector(propertyTypeHintForName:)])            
                objectType = [targetObject propertyTypeHintForName:objectPropertyName];
            
            if (!objectType)
            {
                @throw [NSException exceptionWithName:@"CannotDecode" reason:@"Trying to decode an array into an object property that has no type hint"
                                             userInfo:nil];
            }
            
            // Go over each element in the dictionary provided array
            for (id arrayObj in sourceObject)
            {   
                if ([[arrayObj class] isSubclassOfClass:[NSDictionary class]])
                {
                    // If it's a dictionary, recursively create a new object
                    id objInstance = [[objectType alloc] init];
                    [self dictionaryToObjectProperties:arrayObj object:objInstance];
                    [newObjects addObject:objInstance];
                }
                else
                {
                    // Otherwise, we'll just keep whatever the dictionary contained
                    [newObjects addObject:arrayObj];
                }
            }
            
            [targetObject setValue:newObjects forKey:objectPropertyName];
        }
        else
        {
            @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The source object was of an undecodable type" userInfo:nil];
        }       
    }
    // Anything non-object that we know is OK, let KVC handle
    else if ([propertyDesc.propertyType isBoolean] || [propertyDesc.propertyType isNumeric] || [propertyDesc.propertyType isString])
    {
        [targetObject setValue:sourceObject forKey:objectPropertyName];
    }
    else
    {
        @throw [NSException exceptionWithName:@"CannotDecode" reason:@"The object has properties outside of the decodable set" userInfo:nil];
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
