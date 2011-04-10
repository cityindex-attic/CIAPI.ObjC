// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//
@interface CIAPIG2SessionValidationResponse : NSObject<RKObjectMappable> 
{
  NSMutableArray *ClientAccountIds;
  NSMutableArray *TradingAccountIds;
  BOOL IsValid;
}

// ClientAccountIds that this session is authorized to work with
@property (retain) NSMutableArray *ClientAccountIds;

// TradingAccountIds that this session is authorized to work with
@property (retain) NSMutableArray *TradingAccountIds;

// Whether this session token is still valid
@property BOOL IsValid;

@end

