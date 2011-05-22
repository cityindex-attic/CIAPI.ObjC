//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPILookup : NSObject {
  id Id;
  id Description;
  id DisplayOrder;
  id TranslationTextId;
  id TranslationText;
  id IsActive;
  id IsAllowed;
}

// lookups id. 
@property (readonly) id Id;
// lookup items description. 
@property (readonly) id Description;
// order the items should be displayed on a user interface. 
@property (readonly) id DisplayOrder;
// translation text id. 
@property (readonly) id TranslationTextId;
// translated text. 
@property (readonly) id TranslationText;
// is active. 
@property (readonly) id IsActive;
// is allowed. 
@property (readonly) id IsAllowed;

@end
