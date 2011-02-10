//
//  AdapterInfo.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 27/11/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <CoreData/CoreData.h>

@class ServerConfig;

@interface AdapterInfo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ServerConfig * server;

@end



