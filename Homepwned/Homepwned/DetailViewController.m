//
//  HomepwnedViewController.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/8/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemsViewController.h"
#import "ItemDatePickerViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id) initForNewItem:(BOOL) newItem {
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    if (self) {
        if (newItem) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                  target:self
                                                                                                  action:@selector(cancel:)];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                  target:self
                                                                                                  action:@selector(save:)];
        }
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"Wrong Initializer" reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    UIColor *color;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        color = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    }
    else {
        color = [UIColor lightGrayColor];
    }
    self.view.backgroundColor = color;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    titleField.text = _item.title;
    dateLabel.text = [[NSDate dateWithTimeIntervalSinceReferenceDate:_item.date] description];
    imageView.image = [[BNRImageStore sharedInstance] imageForKey:_item.imageKey size:BNRFullSize];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _item.title = titleField.text;
    [self.view endEditing:YES];
}

- (void) setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = item.title;
}

- (void) editDate:(id)sender {
    ItemDatePickerViewController *ivc = [[ItemDatePickerViewController alloc] init];
    ivc.item = _item;
    [self.navigationController pushViewController:ivc animated:YES];
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (imagePickerPopover) {
            [imagePickerPopover dismissPopoverAnimated:YES];
            imagePickerPopover = nil;
            return;
        }
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        imagePickerPopover.delegate = self;
        [imagePickerPopover presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES];
    }
    else {
        [self.navigationController presentViewController:imagePicker animated:YES completion:^{
            imageView.image = [[BNRImageStore sharedInstance] imageForKey:_item.imageKey size:BNRFullSize];
        }];
    }
    
}

- (IBAction)dismissEditor:(id)sender {
    [self.view endEditing:YES];
}

- (void) save:(id) sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:_dismissBlock];
}

- (void) cancel:(id) sender {
    [[BNRItemStore sharedInstance] deleteItem:_item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:_dismissBlock];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    BNRImageStore *store = [BNRImageStore sharedInstance];
    if (_item.imageKey) {
        [store deleteImageForKey:_item.imageKey];
    }
    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *key = (__bridge NSString*)uuidString;
    _item.imageKey = key;
    [store setImage:image forKey:key];
    CFRelease(uuid);
    CFRelease(uuidString);
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imageView.image = [[BNRImageStore sharedInstance] imageForKey:_item.imageKey size:BNRFullSize];
        imagePickerPopover = nil;
    }
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    imagePickerPopover = nil;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
