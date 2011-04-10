// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//
@interface CIAPILogOnRequest : NSObject<RKObjectMappable> 
{
  NSString *UserName;
  NSString *Password;
}

// Username is case sensitive
@property (retain) NSString *UserName;

// Password is case sensitive
@property (retain) NSString *Password;

@end

