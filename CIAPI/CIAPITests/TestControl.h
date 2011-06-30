//
//  TestControl.h
//  CIAPI
//
//  Created by Adam Wright on 24/05/2011.
//

// This will run tests that make requests of the CityIndex test servers, rather than local code units
// Assuming the network is alive, all tests should pass. However, this can be slow
// Set to 0 for testing units only, rather than system integration

#define TEST_REQUESTS 1