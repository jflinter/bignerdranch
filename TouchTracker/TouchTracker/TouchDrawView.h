//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Jack Flintermann on 11/14/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Line;

@interface TouchDrawView : UIView<UIGestureRecognizerDelegate> {
    NSMutableDictionary *linesInProgress;
    NSMutableArray *completeLines;
    UIPanGestureRecognizer *panRecognizer;
}

@property(nonatomic, weak) Line *selectedLine;
- (void) clearAll;
- (Line *) lineAtPoint:(CGPoint) p;


@end
