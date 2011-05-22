//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIPrice : NSObject {
  id MarketId;
  id TickDate;
  id Bid;
  id Offer;
  id Price;
  id High;
  id Low;
  id Change;
  id Direction;
  id AuditId;
}

// The Market that the Price is related to. 
@property (readonly) id MarketId;
// The date of the Price. Always expressed in UTC. 
@property (readonly) id TickDate;
// The current Bid price (price at which the customer can sell). 
@property (readonly) id Bid;
// The current Offer price (price at which the customer can buy, some times referred to as Ask price). 
@property (readonly) id Offer;
// The current mid price. 
@property (readonly) id Price;
// The highest price reached for the day. 
@property (readonly) id High;
// The lowest price reached for the day 
@property (readonly) id Low;
// The change since the last price (always positive. See Direction for direction) 
@property (readonly) id Change;
// The direction of movement since the last price. 1 == up, 0 == down 
@property (readonly) id Direction;
// A unique id for this price. Treat as a unique, but random string 
@property (readonly) id AuditId;

@end
