//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Jack Flintermann on 11/15/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewController.h"

@interface ListViewController : UITableViewController {
    NSURLConnection *connection;
    NSArray *listings;
    NSMutableData *jsonData;
}
@property (nonatomic, strong) WebViewController *webViewController;
- (void) fetchData;

@end
