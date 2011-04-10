// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "CIAPINewsDetail.h"

//JSON returned from News Detail GET request
@interface CIAPIGetNewsDetailResponse : NSObject<RKObjectMappable> 
{
  CIAPINewsDetail *NewsDetail;
}

// The details of the news item
@property (retain) CIAPINewsDetail *NewsDetail;

@end

