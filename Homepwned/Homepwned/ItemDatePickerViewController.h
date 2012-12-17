//
//  ItemDatePickerViewController.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/9/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface ItemDatePickerViewController : UIViewController {
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UILabel *dateLabel;
}

@property(nonatomic, readwrite, strong) BNRItem *item;

@end
