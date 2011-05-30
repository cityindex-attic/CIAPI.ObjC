//
//  CIAPIObjectListResponse.m
//  CIAPI
//
//  Created by Adam Wright on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CIAPIObjectListResponse.h"


@implementation CIAPIObjectListResponse

@synthesize array;

- (BOOL)setupFromDictionary:(NSDictionary*)dictionary error:(NSError**)error
{
    // Note the property key for the array (i.e. the only property)
    NSString *arrayPropertyName = [[dictionary allKeys] objectAtIndex:0];
    
    if (arrayPropertyName == nil)
    {
        // TODO: Error handling
        return NO;
    }

    BOOL result = [super setupFromDictionary:dictionary error:error];
    
    array = [self valueForKey:arrayPropertyName];
    
    return result;
}

- (NSUInteger)count
{
    return [array count];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [array objectAtIndex:index];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    return [array countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
