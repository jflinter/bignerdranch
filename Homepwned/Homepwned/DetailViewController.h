//
//  DetailViewController.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/8/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate> {
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UITextField *titleField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    
    UIPopoverController *imagePickerPopover;
}

- (id) initForNewItem:(BOOL) newItem;

@property(nonatomic, strong) BNRItem *item;
@property(nonatomic, copy) void (^dismissBlock)(void);
- (IBAction)editDate:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)dismissEditor:(id)sender;

@end
