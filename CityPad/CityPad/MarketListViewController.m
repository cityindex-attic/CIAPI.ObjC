//
//  MarketListViewController.m
//  CityPad
//
//  Created by Adam Wright on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarketListViewController.h"

@implementation MarketListViewController
@synthesize marketTable;
@synthesize apiClient;
@synthesize clientAccountID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CIAPIListSpreadMarketsRequest *marketsRequest = [[CIAPIListSpreadMarketsRequest alloc] initWithSearchByMarketName:@"a" searchByMarketCode:@"" clientAccountId:clientAccountID];
    
    [apiClient makeRequest:marketsRequest successBlock:^(CIAPIRequestToken *request, id response) {
        markets = [response retain];
        [marketTable reloadData];
    } failureBlock:^(CIAPIRequestToken *request, NSError *error) {
    } error:nil];
}

- (void)viewDidUnload
{
    [self setMarketTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [marketTable release];
    [super dealloc];
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [markets count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[markets objectAtIndex:indexPath.row] Name];
    
    // Configure the cell...
    
    return cell;
}

@end
