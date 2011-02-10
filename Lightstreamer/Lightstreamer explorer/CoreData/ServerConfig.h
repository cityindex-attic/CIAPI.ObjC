//
//  ServerConfig.h
//  Lightstreamer explorer
//
//  Created by Gianluca Bertani on 16/12/10.
//  Copyright 2010 Flying Dolphin Studio. All rights reserved.
//

#import <CoreData/CoreData.h>

@class AdapterInfo;
@class FieldInfo;
@class ItemInfo;

@interface ServerConfig :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * bufferSize;
@property (nonatomic, retain) NSString * selector;
@property (nonatomic, retain) NSString * schema;
@property (nonatomic, retain) NSNumber * maxFrequency;
@property (nonatomic, retain) NSString * adapterSet;
@property (nonatomic, retain) NSString * adapter;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * mode;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* fields;
@property (nonatomic, retain) NSSet* items;
@property (nonatomic, retain) NSSet* adapters;

@end


@interface ServerConfig (CoreDataGeneratedAccessors)
- (void)addFieldsObject:(FieldInfo *)value;
- (void)removeFieldsObject:(FieldInfo *)value;
- (void)addFields:(NSSet *)value;
- (void)removeFields:(NSSet *)value;

- (void)addItemsObject:(ItemInfo *)value;
- (void)removeItemsObject:(ItemInfo *)value;
- (void)addItems:(NSSet *)value;
- (void)removeItems:(NSSet *)value;

- (void)addAdaptersObject:(AdapterInfo *)value;
- (void)removeAdaptersObject:(AdapterInfo *)value;
- (void)addAdapters:(NSSet *)value;
- (void)removeAdapters:(NSSet *)value;

@end

