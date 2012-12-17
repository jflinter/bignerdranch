//
//  ListViewController.m
//  Nerdfeed
//
//  Created by Jack Flintermann on 11/15/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import "ListViewController.h"
#import <SVWebViewController/SVWebViewController.h>
#import "BNRFeedStore.h"

@implementation ListViewController

- (id) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        jsonData = [NSMutableData data];
        [self fetchData];
    }
    return self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listings.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *listing = [listings objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcell"];
    cell.textLabel.text = [listing objectForKey:@"street_address"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *listing = [listings objectAtIndex:indexPath.row];
    NSNumber *listingId = [listing objectForKey:@"id"];
    NSString *urlString = [NSString stringWithFormat:@"http://onradpad.com/listings/%@", listingId];
    SVWebViewController *webView = [[SVWebViewController alloc] initWithAddress:urlString];
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void) fetchData {
    [[BNRFeedStore sharedInstance] fetchItemsWithCompletion:^(id result, NSError *error) {
        listings = [result objectForKey:@"listings"];
        [self.tableView reloadData];
    }];
}

@end
