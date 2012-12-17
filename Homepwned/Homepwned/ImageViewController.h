//
//  ImageViewController.h
//  Homepwned
//
//  Created by Jack Flintermann on 11/10/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UIScrollViewDelegate> {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imageView;
}

@property(nonatomic, strong) UIImage *image;

@end
