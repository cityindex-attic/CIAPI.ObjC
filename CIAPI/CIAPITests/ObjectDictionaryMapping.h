//
//  TestJSONMapping.h
//  CIAPI
//
//  Created by Adam Wright on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

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
