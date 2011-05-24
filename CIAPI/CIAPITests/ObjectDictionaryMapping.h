//
//  TestJSONMapping.h
//  CIAPI
//
//  Created by Adam Wright on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#define USE_APPLICATION_UNIT_TEST 1

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "TestControl.h"

// The test object we're mapping
@interface FlatTestObject : NSObject
{
    int anIntProperty;
    BOOL aBoolProperty;
    NSString *aStringProperty;
}

@property int anIntProperty;
@property BOOL aBoolProperty;
@property (retain) NSString *aStringProperty;

@end

@interface NestedInheritedTestObject : FlatTestObject
{
    FlatTestObject *subObject;
}

@property (retain) FlatTestObject *subObject;

@end


@interface ObjectDictionaryMapping : SenTestCase {
    
}

- (void)testObjectToDictionary;
- (void)testNestedInheritedObjectToDictionary;

- (void)testDictionaryToObject;
- (void)testNestedInheritedDictionaryToObject;
- (void)testNestedInheritedDictionaryWithNullSubObjectToObject;

@end
