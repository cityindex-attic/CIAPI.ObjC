//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIGetMessagePopupResponse : CIAPIObjectResponse {
  BOOL AskForClientApproval;
  NSString* Message;
}

// Should the client application ask for client approval. 
@property (readonly) BOOL AskForClientApproval;
// The message to display to the client. 
@property (readonly) NSString* Message;

@end
