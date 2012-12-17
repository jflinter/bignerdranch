//
//  ImageViewController.m
//  Homepwned
//
//  Created by Jack Flintermann on 11/10/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () {
    UIStatusBarStyle previousStyle;
}
@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        previousStyle = [UIApplication sharedApplication].statusBarStyle;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                              target:self
                                                                                              action:@selector(cancel:)];
    }
    return self;
}

- (void) viewDidLoad {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    scrollView.contentSize = _image.size;
    imageView.frame = CGRectMake(0, 0, _image.size.width, _image.size.height);
    imageView.image = _image;
    CGFloat top = (scrollView.frame.size.height - _image.size.height) / 2;
    CGFloat left = (scrollView.frame.size.width - _image.size.width) / 2;
    scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left);
    [self becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = previousStyle;
    
}

- (void) cancel:(id) sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

@end
