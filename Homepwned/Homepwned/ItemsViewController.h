//
//  ItemsViewController.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tableView;
}


@end
