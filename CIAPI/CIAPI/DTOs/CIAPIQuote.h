// Generated on 2011-04-10T20:58:17+01:00
#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>


//A quote for a specific order request
@interface CIAPIQuote : NSObject<RKObjectMappable> 
{
  int CurrencyId;
  int MarketId;
  NSNumber *Quantity;
  NSString *RequestDateTime;
  int TypeId;
  NSNumber *BidAdjust;
  NSNumber *BidPrice;
  int QuoteId;
  int StatusId;
  NSNumber *OfferAdjust;
  NSNumber *OfferPrice;
  int OrderId;
}

// ???
@property int CurrencyId;

// The Market the Quote is related to
@property int MarketId;

// ???
@property (retain) NSNumber *Quantity;

// The timestamp the quote was requested. Always expressed in UTC
@property (retain) NSString *RequestDateTime;

// ???
@property int TypeId;

// ????
@property (retain) NSNumber *BidAdjust;

// ????
@property (retain) NSNumber *BidPrice;

// The uniqueId of the Quote
@property int QuoteId;

// ???
@property int StatusId;

// ???
@property (retain) NSNumber *OfferAdjust;

// ???
@property (retain) NSNumber *OfferPrice;

// The Order the Quote is related to
@property int OrderId;

@end

