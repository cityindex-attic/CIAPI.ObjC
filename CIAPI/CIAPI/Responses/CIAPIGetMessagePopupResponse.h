//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetMessagePopupResponse : CIAPIObjectResponse {
  id AskForClientApproval;
  id Message;
}

// Should the client application ask for client approval. 
@property (readonly) id AskForClientApproval;
// The message to display to the client. 
@property (readonly) id Message;

@end
