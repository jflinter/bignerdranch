//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "TimeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation TimeViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:@"TimeViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.tabBarItem.title = @"Time";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    originalButtonFrame = showTimeButton.frame;
    CGRect offsetFrame = showTimeButton.frame;
    offsetFrame.origin.x = -1 * showTimeButton.frame.size.width;
    showTimeButton.frame = offsetFrame;
    [self showCurrentTime:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.6 animations:^{
        showTimeButton.frame = originalButtonFrame;
    } completion:^(BOOL finished) {
        CAKeyframeAnimation *fadeInOut = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        fadeInOut.duration = 1.2;
        fadeInOut.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        fadeInOut.repeatCount = HUGE_VALF;
        fadeInOut.values = @[
        [NSNumber numberWithFloat:1.0],
        [NSNumber numberWithFloat:0.1],
        [NSNumber numberWithFloat:1.0]
        ];
        [showTimeButton.layer addAnimation:fadeInOut forKey:@"fadeInOutAnimation"];
    }];
}

-(IBAction)showCurrentTime:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterMediumStyle;
    timeLabel.text = [formatter stringFromDate:date];
    [self bounceTimeLabel];
}

-(void) bounceTimeLabel {
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D forward1 = CATransform3DMakeScale(1.3, 1.3, 1);
    CATransform3D back1 = CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
    bounce.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:forward1],
        [NSValue valueWithCATransform3D:back1],
        [NSValue valueWithCATransform3D:forward2],
        [NSValue valueWithCATransform3D:back2],
        [NSValue valueWithCATransform3D:CATransform3DIdentity]
    ];
    bounce.duration = 0.6;
    [timeLabel.layer addAnimation:bounce forKey:@"bounceAnimation"];
    
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.values = @[
        [NSNumber numberWithFloat:1.0],
        [NSNumber numberWithFloat:0.3],
        [NSNumber numberWithFloat:1.0],
        [NSNumber numberWithFloat:0.7],
        [NSNumber numberWithFloat:1.0],
        [NSNumber numberWithFloat:1.0]
    ];
    opacity.duration = 0.6;
    [timeLabel.layer addAnimation:opacity forKey:@"opacityAnimation"];
}

- (void) spinTimeLabel {
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spin.toValue = [NSNumber numberWithFloat:M_PI * 2];
    spin.duration = 1.0;
    spin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    spin.delegate = self;
    [timeLabel.layer addAnimation:spin forKey:@"spinAnimation"];
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@, %d", anim, flag);
}

@end
