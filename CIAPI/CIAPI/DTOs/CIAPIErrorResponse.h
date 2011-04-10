// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "CIAPIErrorCode.h"

//This is a description of ErrorResponseDTO
@interface CIAPIErrorResponse : NSObject<RKObjectMappable> 
{
  NSString *ErrorMessage;
  enum CIAPIErrorCode ErrorCode;
}

// This is a description of the ErrorMessage property
@property (retain) NSString *ErrorMessage;

// The error code
@property enum CIAPIErrorCode ErrorCode;

@end

