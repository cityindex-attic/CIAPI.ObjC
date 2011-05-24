//
//  PropertyDescriptionDecoder.h
//  ObjC2TypeDecoder
//
//  Created by Adam Wright on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDecoder.h"

/*
 R : The property is read-only (readonly).
 C : The property is a copy of the value last assigned (copy).
 & : The property is a reference to the value last assigned (retain).
 N : The property is non-atomic (nonatomic).
 G<name> : The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,).
 S<name> : The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,).
 D : The property is dynamic (@dynamic).
 W : The property is a weak reference (__weak).
 P : The property is eligible for garbage collection.
 t<encoding> : Specifies the type using old-style encoding.
 */

@interface PropertyDescriptionDecoder : NSObject {
    TypeDecoder *propertyType;
    
    BOOL isReadOnly;
    BOOL isCopy;
    BOOL isRetain;
    BOOL isNonAtomic;
    BOOL isDynamic;
    BOOL isWeakReference;
    BOOL isGCEligable;
    NSString *customGetterName;
    NSString *customSetterName;
    NSString *backingVariable;
}

@property (readonly) TypeDecoder *propertyType;
@property (readonly) BOOL isReadOnly;
@property (readonly) BOOL isCopy;
@property (readonly) BOOL isRetain;
@property (readonly) BOOL isNonAtomic;
@property (readonly) BOOL isDynamic;
@property (readonly) BOOL isWeakReference;
@property (readonly) BOOL isGCEligable;
@property (readonly) NSString *customGetterName;
@property (readonly) NSString *customSetterName;
@property (readonly) NSString *backingVariable;

+ (PropertyDescriptionDecoder*)propertyDescriptionByDecodingString:(const char*)propCString;

- (NSString*)string;

@end
