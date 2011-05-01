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
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (id itemJSON in dictionary)
    {
        id item = [[[[self contentsClass] alloc] init] autorelease];
        
        if (![item setupFromDictionary:itemJSON error:error])
        {
            return NO;
        }
        
        [tempArray addObject:item];
    }
    
    array = [[NSArray arrayWithArray:tempArray] retain];
    
    return YES;
}

- (Class)contentsClass
{
    assert(FALSE);
    return nil;
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
