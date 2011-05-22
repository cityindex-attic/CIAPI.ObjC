//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIQuoteResponse : CIAPIObjectResponse {
  id QuoteId;
  id Status;
  id StatusReason;
}

// quote id. 
@property (readonly) id QuoteId;
// quote status. 
@property (readonly) id Status;
// quote status reason. 
@property (readonly) id StatusReason;

@end
