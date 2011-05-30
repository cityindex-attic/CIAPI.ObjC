//
//  CIAPIClientAccountMargin.h
//  CIAPI
//
//  Copyright 2011 Adam Wright/CityIndex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CIAPIObjectResponse.h"
#import "CIAPIObjectListResponse.h"



@interface CIAPIClientAccountMargin : CIAPIObjectResponse {
  double Cash;
  double Margin;
  double MarginIndicator;
  double NetEquity;
  double OpenTradeEquity;
  double TradeableFunds;
  double PendingFunds;
  double TradingResource;
  double TotalMarginRequirement;
  NSInteger CurrencyId;
  NSString* CurrencyISO;
}

// cash balance expressed in the clients base currency. 
@property (readonly) double Cash;
// The client account's total margin requirement expressed in base currency. 
@property (readonly) double Margin;
// Margin indicator expressed as a percentage. 
@property (readonly) double MarginIndicator;
// Net equity expressed in the clients base currency. 
@property (readonly) double NetEquity;
// open trade equity (open / unrealised PNL) expressed in the client's base currency. 
@property (readonly) double OpenTradeEquity;
// tradable funds expressed in the client's base currency. 
@property (readonly) double TradeableFunds;
// N/A 
@property (readonly) double PendingFunds;
// trading resource expressed in the client's base currency. 
@property (readonly) double TradingResource;
// total margin requirement expressed in the client's base currency. 
@property (readonly) double TotalMarginRequirement;
// The clients base currency id. 
@property (readonly) NSInteger CurrencyId;
// The clients base currency iso code. 
@property (readonly) NSString* CurrencyISO;

@end
