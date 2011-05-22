//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIGetNewsDetailResponse : CIAPIObjectResponse {
  id NewsDetail;
}

// The details of the news item 
@property (readonly) id NewsDetail;

@end
