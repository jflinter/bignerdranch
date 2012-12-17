//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HypnosisView;

@interface HypnosisterAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate> {
    HypnosisView *hypnosisView;
}

@property (strong, nonatomic) UIWindow *window;

@end
