//
//  HypnosisView.h
//  Hypnosister
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HypnosisView : UIView {
    CALayer *mainLayer;
}

@property(nonatomic, strong) UIColor *circleColor;

@end
