// Generated on 2011-04-05T16:57:43+01:00
#import <Foundation/Foundation.h>


//A Price for a specific Market
@interface CIAPIPrice : NSObject 
{
  int Direction;
  int MarketId;
  NSString *AuditId;
  NSNumber *High;
  NSString *TickDate;
  NSNumber *Change;
  NSNumber *Bid;
  NSNumber *Offer;
  NSNumber *Low;
  NSNumber *Price;
}

// The direction of movement since the last price. 1 == up, 0 == down
@property int Direction;

// The Market that the Price is related to
@property int MarketId;

// A unique id for this price. Treat as a unique, but random string
@property (retain) NSString *AuditId;

// The highest price reached for the day
@property (retain) NSNumber *High;

// The date of the Price. Always expressed in UTC
@property (retain) NSString *TickDate;

// The change since the last price (always positive. See Direction for direction)
@property (retain) NSNumber *Change;

// The current Bid price (price at which the customer can sell)
@property (retain) NSNumber *Bid;

// The current Offer price (price at which the customer can buy)
@property (retain) NSNumber *Offer;

// The lowest price reached for the day
@property (retain) NSNumber *Low;

// The current mid price
@property (retain) NSNumber *Price;

@end

