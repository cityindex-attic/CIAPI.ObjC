// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>

#import "CIAPIErrorCode.h"

//This is a description of ErrorResponseDTO
@interface CIAPIErrorResponse : NSObject 
{
  NSString *ErrorMessage;
  enum CIAPIErrorCode ErrorCode;
}

// This is a description of the ErrorMessage property
@property (retain) NSString *ErrorMessage;

// The error code
@property enum CIAPIErrorCode ErrorCode;

@end

