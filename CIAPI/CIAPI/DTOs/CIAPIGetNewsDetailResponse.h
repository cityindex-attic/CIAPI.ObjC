// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPINewsDetail.h"

//JSON returned from News Detail GET request
@interface CIAPIGetNewsDetailResponse : NSObject 
{
  CIAPINewsDetail *NewsDetail;
}

// The details of the news item
@property (retain) CIAPINewsDetail *NewsDetail;

@end

