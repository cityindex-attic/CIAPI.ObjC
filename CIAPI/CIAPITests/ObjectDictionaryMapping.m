//
//  TestJSONMapping.m
//  CIAPI
//
//  Created by Adam Wright on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectDictionaryMapping.h"

#import "ObjectPropertiesDictionaryMapper.h"

@implementation FlatTestObject

@synthesize anIntProperty;
@synthesize aBoolProperty;
@synthesize aStringProperty;

- (id)init
{
    self = [super init];
    
    self.anIntProperty = 5;
    self.aBoolProperty = FALSE;
    self.aStringProperty = @"Hello World";
    
    return self;
}

@end

@implementation NestedInheritedTestObject

@synthesize subObject;

- (id)init
{
    self = [super init];
    
    self.subObject = [[FlatTestObject alloc] init];
    
    return self;
}

-(void)dealloc
{
    [subObject release];
    
    [super dealloc];
}

@end

@implementation ObjectDictionaryMapping

- (void)testObjectToDictionary
{
    FlatTestObject *anObject = [[[FlatTestObject alloc] init] autorelease];

    NSDictionary *result = [ObjectPropertiesDictionaryMapper objectPropertiesToDictionary:anObject];
    
    STAssertEquals([result count], (NSUInteger)3, @"Encoded flat object should have 3 entries");
    
    STAssertEquals([[result objectForKey:@"anIntProperty"] intValue], 5, @"Encoded flat object should have 5 for anIntProperty");
    STAssertEqualObjects([result objectForKey:@"aStringProperty"], @"Hello World", @"Encoded flat object should have a Hello World in aStringProperty");
}

- (void)testNestedInheritedObjectToDictionary
{
    NestedInheritedTestObject *anObject = [[[NestedInheritedTestObject alloc] init] autorelease];
    
    NSDictionary *result = [ObjectPropertiesDictionaryMapper objectPropertiesToDictionary:anObject];
    
    STAssertEquals([result count], (NSUInteger)4, @"Encoded nested object should have 4 entries");
    STAssertEquals([[result objectForKey:@"anIntProperty"] intValue], 5, @"Encoded object should have 5 for anIntProperty");
    STAssertEqualObjects([result objectForKey:@"aStringProperty"], @"Hello World", @"Encoded object should have a Hello World in aStringProperty");
    STAssertNotNil([result objectForKey:@"subObject"], @"Encoded nested sub object should be non-nil");
    
    STAssertEquals([[result objectForKey:@"subObject"] count], (NSUInteger)3, @"Encoded sub-object should have 4 entries");
    STAssertEquals([[[result objectForKey:@"subObject"] objectForKey:@"anIntProperty"] intValue], 5, @"Encoded sub-object should have 5 for anIntProperty");
    STAssertEqualObjects([[result objectForKey:@"subObject"] objectForKey:@"aStringProperty"], @"Hello World", @"Encoded sub-object should have a Hello World in aStringProperty");

}

- (void)testDictionaryToObject
{
    NSDictionary *encodedObject = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:7], @"anIntProperty", [NSNumber numberWithBool:TRUE], @"aBoolProperty",
                                   @"World Hello", @"aStringProperty", nil];
    
    FlatTestObject *testObject = [[FlatTestObject alloc] init];
    [ObjectPropertiesDictionaryMapper dictionaryToObjectProperties:encodedObject object:testObject];
    
    STAssertEquals(testObject.anIntProperty, 7, @"The decoded integer should have been 7");
    STAssertEquals(testObject.aBoolProperty, YES, @"The decoded boolean should have been YES");
    STAssertEqualObjects(testObject.aStringProperty, @"World Hello", @"The decoded string should have been \"World Hello\"");
}

- (void)testNestedInheritedDictionaryToObject
{
    NSDictionary *encodedObject = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:7], @"anIntProperty", [NSNumber numberWithBool:TRUE], @"aBoolProperty",
                                   @"World Hello", @"aStringProperty", [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:7], @"anIntProperty", [NSNumber numberWithBool:TRUE], @"aBoolProperty", @"World Hello", @"aStringProperty", nil], @"subObject", nil];
    
    NestedInheritedTestObject *testObject = [[NestedInheritedTestObject alloc] init];
    [ObjectPropertiesDictionaryMapper dictionaryToObjectProperties:encodedObject object:testObject];
    
    STAssertEquals(testObject.anIntProperty, 7, @"The decoded integer should have been 7");
    STAssertEquals(testObject.aBoolProperty, YES, @"The decoded boolean should have been YES");
    STAssertEqualObjects(testObject.aStringProperty, @"World Hello", @"The decoded string should have been \"World Hello\"");
    STAssertNotNil(testObject.subObject, @"Sub object should be non-nil");
    STAssertEquals(testObject.subObject.anIntProperty, 7, @"The decoded integer should have been 7");
    STAssertEquals(testObject.subObject.aBoolProperty, YES, @"The decoded boolean should have been YES");
    STAssertEqualObjects(testObject.subObject.aStringProperty, @"World Hello", @"The decoded string should have been \"World Hello\"");
}

- (void)testNestedInheritedDictionaryWithNullSubObjectToObject
{
    NSDictionary *encodedObject = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:7], @"anIntProperty", [NSNumber numberWithBool:TRUE], @"aBoolProperty",
                                   @"World Hello", @"aStringProperty", [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:7], @"anIntProperty", [NSNumber numberWithBool:TRUE], @"aBoolProperty", @"World Hello", @"aStringProperty", nil], @"subObject", nil];
    
    NestedInheritedTestObject *testObject = [[NestedInheritedTestObject alloc] init];
    testObject.subObject = nil;
    [ObjectPropertiesDictionaryMapper dictionaryToObjectProperties:encodedObject object:testObject];
    
    STAssertEquals(testObject.anIntProperty, 7, @"The decoded integer should have been 7");
    STAssertEquals(testObject.aBoolProperty, YES, @"The decoded boolean should have been YES");
    STAssertEqualObjects(testObject.aStringProperty, @"World Hello", @"The decoded string should have been \"World Hello\"");
    STAssertNotNil(testObject.subObject, @"Sub object should be non-nil");
    STAssertEquals(testObject.subObject.anIntProperty, 7, @"The decoded integer should have been 7");
    STAssertEquals(testObject.subObject.aBoolProperty, YES, @"The decoded boolean should have been YES");
    STAssertEqualObjects(testObject.subObject.aStringProperty, @"World Hello", @"The decoded string should have been \"World Hello\"");
}

@end
