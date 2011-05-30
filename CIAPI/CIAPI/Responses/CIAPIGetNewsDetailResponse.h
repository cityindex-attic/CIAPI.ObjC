//
//  CIAPIGetNewsDetailResponse.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"

#import "CIAPINewsDetail.h"


@interface CIAPIGetNewsDetailResponse : CIAPIObjectResponse {
  CIAPINewsDetail* NewsDetail;
}

// The details of the news item 
@property (readonly) CIAPINewsDetail* NewsDetail;

@end
