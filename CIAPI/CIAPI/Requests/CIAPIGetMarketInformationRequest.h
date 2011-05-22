//
//  CIAPIGetMarketInformationRequest.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectRequest.h"

// <p>Get Market Information for the specified market.</p>
 
@interface CIAPIGetMarketInformationRequest : CIAPIObjectRequest {
  id marketId;
}

  // The marketId 
  @property (retain) id marketId;

@end
