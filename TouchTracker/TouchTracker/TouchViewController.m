//
//  TouchViewController.m
//  TouchTracker
//
//  Created by Jack Flintermann on 11/14/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchDrawView.h"
@interface TouchViewController ()

@end

@implementation TouchViewController

- (void) loadView {
    self.view = [[TouchDrawView alloc] initWithFrame:CGRectZero];
}


@end
