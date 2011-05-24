//
//  PropertyDescriptionDecoder.m
//  ObjC2TypeDecoder
//
//  Created by Adam Wright on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyDescriptionDecoder.h"


@implementation PropertyDescriptionDecoder

@synthesize propertyType;
@synthesize isReadOnly;
@synthesize isCopy;
@synthesize isRetain;
@synthesize isNonAtomic;
@synthesize isDynamic;
@synthesize isWeakReference;
@synthesize isGCEligable;
@synthesize customGetterName;
@synthesize customSetterName;
@synthesize backingVariable;

+ (PropertyDescriptionDecoder*)propertyDescriptionByDecodingString:(const char*)propCString
{
    if (propCString == NULL)
        return nil;
    
    NSString *propString = [NSString stringWithCString:propCString encoding:NSASCIIStringEncoding];
    
    PropertyDescriptionDecoder *decoder = [[[PropertyDescriptionDecoder alloc] init] autorelease];
    
    NSScanner *scanner = [NSScanner scannerWithString:propString];
    
    NSString *token = nil;
    while ([scanner scanUpToString:@"," intoString:&token])
    {
        if ([token isEqualToString:@"R"])
            decoder->isReadOnly = YES;
        else if ([token isEqualToString:@"C"])
            decoder->isCopy = YES;
        else if ([token isEqualToString:@"&"])
            decoder->isRetain = YES;
        else if ([token isEqualToString:@"N"])
            decoder->isNonAtomic = YES;
        else if ([token isEqualToString:@"D"])
            decoder->isDynamic = YES;
        else if ([token isEqualToString:@"W"])
            decoder->isWeakReference = YES;
        else if ([token isEqualToString:@"P"])
            decoder->isGCEligable = YES;
        else if ([token characterAtIndex:0] == 'T')
            decoder->propertyType = [[TypeDecoder typeDecoderByDecodingString:token] retain];
        else if ([token characterAtIndex:0] == 'V')
            decoder->backingVariable = [[token substringFromIndex:1] retain];
        else if ([token characterAtIndex:0] == 'G')
            decoder->customGetterName = [[token substringFromIndex:1] retain];
        else if ([token characterAtIndex:0] == 'S')
            decoder->customSetterName = [[token substringFromIndex:1] retain];
        else
            @throw [NSException exceptionWithName:@"CannotDecode" reason:@"Token not handled" userInfo:nil];
        
        // Skip the , for the next scan
        [scanner scanString:@"," intoString:nil];   
    }
    
    return decoder;
}

- (void)dealloc
{
    [propertyType release];
    [backingVariable release];
    [customGetterName release];
    [customSetterName release];
    
    [super dealloc];
}

- (NSString*)string
{
    NSMutableString *result = [NSMutableString string];
    
    if (isReadOnly)
        [result appendString:@" (readonly)"];
    if (isCopy)
        [result appendString:@" (copy)"];
    if (isRetain)
        [result appendString:@" (retain)"];
    if (isNonAtomic)
        [result appendString:@" (nonatomic)"];
    if (isDynamic)
        [result appendString:@" (dynamic)"];
    if (isWeakReference)
        [result appendString:@" (__weak)"];
    if (isGCEligable)
        [result appendString:@" (gc)"];
    
    [result appendFormat:@" %@ %@", [propertyType string], backingVariable];
    
    return result;
}


@end
