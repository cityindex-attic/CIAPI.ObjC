//
//  CIAPIPrice.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIPrice : CIAPIObjectResponse {
  NSInteger MarketId;
  NSString* TickDate;
  double Bid;
  double Offer;
  double Price;
  double High;
  double Low;
  double Change;
  NSInteger Direction;
  NSString* AuditId;
}

// The Market that the Price is related to. 
@property (readonly) NSInteger MarketId;
// The date of the Price. Always expressed in UTC. 
@property (readonly) NSString* TickDate;
// The current Bid price (price at which the customer can sell). 
@property (readonly) double Bid;
// The current Offer price (price at which the customer can buy, some times referred to as Ask price). 
@property (readonly) double Offer;
// The current mid price. 
@property (readonly) double Price;
// The highest price reached for the day. 
@property (readonly) double High;
// The lowest price reached for the day 
@property (readonly) double Low;
// The change since the last price (always positive. See Direction for direction) 
@property (readonly) double Change;
// The direction of movement since the last price. 1 == up, 0 == down 
@property (readonly) NSInteger Direction;
// A unique id for this price. Treat as a unique, but random string 
@property (readonly) NSString* AuditId;

@end
