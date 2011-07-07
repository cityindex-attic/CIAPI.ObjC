//
//  main.m
//  CityPad
//
//  Created by Adam Wright on 19/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CityPadAppDelegate.h"

int main(int argc, char *argv[])
{
    int retVal = 0;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([CityPadAppDelegate class]));
    
    
    [pool drain];    
    [pool release];
    
    return retVal;
}
