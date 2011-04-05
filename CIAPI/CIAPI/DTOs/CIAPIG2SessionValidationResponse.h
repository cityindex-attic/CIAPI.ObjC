// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//
@interface CIAPIG2SessionValidationResponse : NSObject 
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

