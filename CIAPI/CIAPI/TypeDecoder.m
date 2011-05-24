//
//  TypeDecoder.m
//  ObjC2TypeDecoder
//
//  Created by Adam Wright on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeDecoder.h"


@implementation TypeDecoder

@synthesize structuralType;
@synthesize decodedType;
@synthesize objectClassName;
@synthesize className;

+ (TypeDecoder*)typeDecoderByDecodingString:(NSString *)encodeString
{
    if (encodeString == nil)
        return nil;
    
    if ([encodeString length] == 0 || [encodeString characterAtIndex:0] != 'T')
        return nil;
    
    TypeDecoder *type = [[[TypeDecoder alloc] init] autorelease];
    
    // The simple types
    // We cheat for syntactic brevity; each type code is the same index in the array as the corresponding decoded type enumeration code
    NSArray *flatTypes = [NSArray arrayWithObjects:@"c", @"i", @"s", @"l", @"q", @"C", @"I", @"S", @"L", @"Q", @"f", @"d", @"B", @"v" , nil];
    
    if ([flatTypes containsObject:[encodeString substringFromIndex:1]])
    {
        type->structuralType = FlatStructure;
        type->decodedType = [flatTypes indexOfObject:[encodeString substringFromIndex:1]];
    }
    else if ([encodeString characterAtIndex:1] == '*')
    {
        // Handle string pointers as a special case (they should really be ^c)
        type->decodedType = PointerStructure;
        type->decodedType = CharType;
    }
    else if ([encodeString characterAtIndex:1] == '@')
    {
        // Object types
        type->decodedType = ObjectType;
        
        if ([encodeString length] > 2 && [encodeString characterAtIndex:2] == '\"')
        {
            NSScanner *quotedStringScanner = [NSScanner scannerWithString:[encodeString substringFromIndex:3]];
            
            [quotedStringScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type->objectClassName];
            
        }
        else
        {
            type->objectClassName = [[NSString stringWithString:@"id"] retain];
        }
    }
    else if ([encodeString characterAtIndex:1] == '#')
    {
        // Class types
        type->decodedType = ClassType;
        
        if ([encodeString length] > 2 && [encodeString characterAtIndex:2] == '\"')
        {
            NSScanner *quotedStringScanner = [NSScanner scannerWithString:[encodeString substringFromIndex:3]];
            
            [quotedStringScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type->className];
            
        }
        else
        {
            type->className = [[NSString stringWithString:@"Class"] retain];
        }
    }
    else if ([encodeString characterAtIndex:1] == ':')
    {
        // Class types
        type->decodedType = SelectorType;
    }
    else if ([encodeString characterAtIndex:1] == '[')
    {
        // Class types
        type->decodedType = UnknownType;
        type->structuralType = ArrayStructure;
    }
    else if ([encodeString characterAtIndex:1] == '{')
    {
        // Class types
        type->decodedType = UnknownType;
        type->structuralType = StructureStructure;
    }
    else if ([encodeString characterAtIndex:1] == '(')
    {
        // Class types
        type->decodedType = UnknownType;
        type->structuralType = UnionStructure;
    }
    else if ([encodeString characterAtIndex:1] == '^')
    {
        // Class types
        type->decodedType = UnknownType;
        type->structuralType = PointerStructure;
    }
    else
    {
        type->decodedType = UnknownType;
        type->structuralType = UnknownStructure;
    }
    
    return type;
}

- (BOOL)isNumeric
{
    if (structuralType != FlatStructure)
        return FALSE;
    
    return (decodedType == IntType || decodedType == ShortType || decodedType == LongType || decodedType == LongLongType || decodedType == UnsignedIntType
            || decodedType == UnsignedShortType || decodedType == UnsignedLongType || decodedType == UnsignedLongLongType);
}

- (BOOL)isString
{
    return (structuralType == FlatStructure && decodedType == ObjectType && [objectClassName isEqualToString:@"NSString"]);
}

- (BOOL)isBoolean
{
    // Objective C BOOL's are signed characters
    return (structuralType == FlatStructure && (decodedType == BoolType || decodedType == CharType));
}

- (BOOL)isNonStringObject
{
    return (structuralType == FlatStructure && decodedType == ObjectType && ![self isString]);
}

- (NSString*)string
{
    if (structuralType == FlatStructure && decodedType == ObjectType)
        return [NSString stringWithFormat:@"%@ ", objectClassName];
    if (structuralType == FlatStructure && decodedType == ClassType)
        return [NSString stringWithFormat:@"%@ ", className];
    else if (decodedType == CharType)
        return [NSString stringWithString:@"char"];
    else if (decodedType == IntType)
        return [NSString stringWithString:@"int"];
    else if (decodedType == ShortType)
        return [NSString stringWithString:@"short"];
    else if (decodedType == LongType)
        return [NSString stringWithString:@"long"];
    else if (decodedType == LongLongType)
        return [NSString stringWithString:@"long long"];
    else if (decodedType == UnsignedCharType)
        return [NSString stringWithString:@"unsigned char"];
    else if (decodedType == UnsignedIntType)
        return [NSString stringWithString:@"unsigned int"];
    else if (decodedType == UnsignedShortType)
        return [NSString stringWithString:@"unsigned short"];
    else if (decodedType == UnsignedLongType)
        return [NSString stringWithString:@"unsigned long"];
    else if (decodedType == UnsignedLongLongType)
        return [NSString stringWithString:@"unsigned long long"];

    return [NSString stringWithString:@"Well, it's certainly *some* type (I've just not got around to stringifying it)"];
}

@end
