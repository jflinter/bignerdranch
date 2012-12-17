//
//  HomepwnedItemCell.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/10/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepwnedItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *myTableView;
- (IBAction)showImage:(id)sender;

@end
