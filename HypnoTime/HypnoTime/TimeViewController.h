//
//  TimeViewController.h
//  HypnoTime
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController {
    CGRect originalButtonFrame;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UIButton *showTimeButton;
    
}

- (IBAction)showCurrentTime:(id)sender;

@end
