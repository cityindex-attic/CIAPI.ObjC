/*
 *  Macros.h
 *  Lightstreamer explorer
 *
 *  Created by Gianluca Bertani on 27/11/10.
 *  Copyright 2010 Flying Dolphin Studio. All rights reserved.
 *
 */

#define DEVICE_IPAD          ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad))
#define DEVICE_XIB(xib)      (DEVICE_IPAD ? [xib stringByAppendingString:@"_iPad"] : [xib stringByAppendingString:@"_iPhone"])

#define SHARED_APP_DELEGATE  ((AppDelegate_Shared *) [[UIApplication sharedApplication] delegate])
#define IPHONE_APP_DELEGATE  ((AppDelegate_iPhone *) [[UIApplication sharedApplication] delegate])
#define IPAD_APP_DELEGATE    ((AppDelegate_iPad *) [[UIApplication sharedApplication] delegate])

