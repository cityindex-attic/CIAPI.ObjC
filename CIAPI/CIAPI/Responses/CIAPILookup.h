//
//  CIAPILookup.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPILookup : CIAPIObjectResponse {
  NSInteger Id;
  NSString* Description;
  NSInteger DisplayOrder;
  NSString* TranslationTextId;
  NSString* TranslationText;
  BOOL IsActive;
  BOOL IsAllowed;
}

// lookups id. 
@property (readonly) NSInteger Id;
// lookup items description. 
@property (readonly) NSString* Description;
// order the items should be displayed on a user interface. 
@property (readonly) NSInteger DisplayOrder;
// translation text id. 
@property (readonly) NSString* TranslationTextId;
// translated text. 
@property (readonly) NSString* TranslationText;
// is active. 
@property (readonly) BOOL IsActive;
// is allowed. 
@property (readonly) BOOL IsAllowed;

@end
