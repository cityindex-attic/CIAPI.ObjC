//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetMarketInformationResponse : CIAPIObjectResponse {
  id MarketInformation;
}

// The requested market information. 
@property (readonly) id MarketInformation;

@end
