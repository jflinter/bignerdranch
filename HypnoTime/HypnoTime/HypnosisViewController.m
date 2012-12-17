//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Jack Flintermann on 11/7/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@interface HypnosisViewController ()

@end

@implementation HypnosisViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnosis";
    }
    return self;
}

- (void) loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:bounds];
    self.view = hypnosisView;
}

@end
