//
//  ItemDatePickerViewController.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/9/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "ItemDatePickerViewController.h"
#import "BNRItem.h"

@interface ItemDatePickerViewController ()

@end

@implementation ItemDatePickerViewController

- (void) viewDidLoad {
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) dateChanged:(id) sender {
    dateLabel.text = datePicker.date.description;
}

- (void) viewWillAppear:(BOOL)animated {
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:_item.date];
    dateLabel.text = date.description;
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _item.date = [datePicker.date timeIntervalSinceReferenceDate];;
}

@end
