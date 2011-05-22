//
//  .h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"

@interface CIAPIClientAccountMargin : NSObject {
  id Cash;
  id Margin;
  id MarginIndicator;
  id NetEquity;
  id OpenTradeEquity;
  id TradeableFunds;
  id PendingFunds;
  id TradingResource;
  id TotalMarginRequirement;
  id CurrencyId;
  id CurrencyISO;
}

// cash balance expressed in the clients base currency. 
@property (readonly) id Cash;
// The client account's total margin requirement expressed in base currency. 
@property (readonly) id Margin;
// Margin indicator expressed as a percentage. 
@property (readonly) id MarginIndicator;
// Net equity expressed in the clients base currency. 
@property (readonly) id NetEquity;
// open trade equity (open / unrealised PNL) expressed in the client's base currency. 
@property (readonly) id OpenTradeEquity;
// tradable funds expressed in the client's base currency. 
@property (readonly) id TradeableFunds;
// N/A 
@property (readonly) id PendingFunds;
// trading resource expressed in the client's base currency. 
@property (readonly) id TradingResource;
// total margin requirement expressed in the client's base currency. 
@property (readonly) id TotalMarginRequirement;
// The clients base currency id. 
@property (readonly) id CurrencyId;
// The clients base currency iso code. 
@property (readonly) id CurrencyISO;

@end
