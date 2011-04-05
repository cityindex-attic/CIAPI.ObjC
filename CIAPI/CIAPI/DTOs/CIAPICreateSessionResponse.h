// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//Response to a CreateSessionRequest
@interface CIAPICreateSessionResponse : NSObject 
{
  NSString *Session;
}

// Your session token (treat as a random string) <BR /> Session tokens are valid for a set period from the time of their creation. <BR /> The period is subject to change, and may vary depending on who you logon as.
@property (retain) NSString *Session;

@end

