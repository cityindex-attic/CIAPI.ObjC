//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIQuoteResponse : CIAPIObjectResponse {
  NSInteger QuoteId;
  NSInteger Status;
  NSInteger StatusReason;
}

// quote id. 
@property (readonly) NSInteger QuoteId;
// quote status. 
@property (readonly) NSInteger Status;
// quote status reason. 
@property (readonly) NSInteger StatusReason;

@end
