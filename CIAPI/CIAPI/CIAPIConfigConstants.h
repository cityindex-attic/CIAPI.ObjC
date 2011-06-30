//
//  CIAPIConfigConstants.h
//  CIAPI
//
//  Created by Adam Wright on 09/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// The base URI at which the REST API is located
#define CIAPI_BASE_URL_STRING @"http://ciapipreprod.cityindextest9.co.uk/TradingApi/"
#define CIAPI_BASE_URL [NSURL URLWithString:@"http://ciapipreprod.cityindextest9.co.uk/TradingApi/"]

// Any key we must provide to authenticate with the API
#define CIAPI_KEY @""

// The number of seconds each request can be inflight for before it times out
#define CIAPI_REQUEST_TIMEOUT_LENGTH 10.0

// Whether the logging system should also NSLog as it goes along
#define CIAPI_LOGGING_ALSO_NS_LOG TRUE

// The minimum log entry severity level to NSLog if CIAPI_LOGGING_ALSO_NS_LOG is set
// 1 (Notes and above) 2 (Warnings and above) 3 (Errors)
#define CIAPI_LOGGING_ALSO_NS_LOG_MIN_LEVEL 2