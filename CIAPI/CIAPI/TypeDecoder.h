//
//  TypeDecoder.h
//  ObjC2TypeDecoder
//
//  Created by Adam Wright on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 c : A char
 i : An int
 s : A short
 l : A long (l is treated as a 32-bit quantity on 64-bit programs)
 q : A long long
 C : An unsigned char
 I : An unsigned int
 S : An unsigned short
 L : An unsigned long
 Q : An unsigned long long
 f : A float
 d : A double
 B : A C++ bool or a C99 _Bool
 v : A void
 * : A character string (char *)
 @ : An object (whether statically typed or typed id)
 # : A class object (Class)
 : : A method selector (SEL) 
 
 [array type] : An array
 {name=type...} : A structure
 (name=type...) : A union
 bnum : A bit field of num bits
 ^type : A pointer to type
 ? : An unknown type (among other things, this code is used for function pointers)
 */

enum DecodedType
{
    CharType = 0,
    IntType,
    ShortType,
    LongType,
    LongLongType,
    UnsignedCharType,
    UnsignedIntType,
    UnsignedShortType,
    UnsignedLongType,
    UnsignedLongLongType,
    FloatType,
    DoubleType,
    BoolType,
    VoidType,
    ObjectType,
    ClassType,
    SelectorType,
    UnknownType
};

enum StructuralType
{
    FlatStructure,
    ArrayStructure,
    StructureStructure,
    UnionStructure,
    BitFieldStructure,
    PointerStructure,
    UnknownStructure
};

@interface TypeDecoder : NSObject {
    enum StructuralType structuralType;
    enum DecodedType decodedType;
    
    NSString *objectClassName;
    NSString *className;
}

@property (readonly) enum StructuralType structuralType;
@property (readonly) enum DecodedType decodedType;
@property (readonly) NSString *objectClassName;
@property (readonly) NSString *className;

+ (TypeDecoder*)typeDecoderByDecodingString:(NSString*)encodeString;

- (BOOL)isNumeric;
- (BOOL)isString;
- (BOOL)isBoolean;
- (BOOL)isNonStringObject;

- (NSString*)string;

@end
