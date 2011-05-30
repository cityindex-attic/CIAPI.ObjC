//
//  CIAPIGetMarketInformationResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPIMarketInformation.h"


@interface CIAPIGetMarketInformationResponse : CIAPIObjectResponse {
  CIAPIMarketInformation* MarketInformation;
}

// The requested market information. 
@property (readonly) CIAPIMarketInformation* MarketInformation;

@end
