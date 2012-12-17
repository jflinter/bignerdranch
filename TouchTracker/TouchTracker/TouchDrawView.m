//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Jack Flintermann on 11/14/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"
@implementation TouchDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        completeLines = [NSMutableArray array];
        linesInProgress = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor whiteColor];
        self.multipleTouchEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];
    
        UILongPressGestureRecognizer *lpRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(longPress:)];
        [self addGestureRecognizer:lpRecognizer];
        panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(moveLine:)];
        panRecognizer.delegate = self;
        panRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panRecognizer];
        
    }
    return self;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer == panRecognizer;
}

- (void) moveLine: (UIPanGestureRecognizer *) gr {
    if (!_selectedLine || [[UIMenuController sharedMenuController] isMenuVisible]) {
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        CGPoint begin = _selectedLine.begin;
        CGPoint end = _selectedLine.end;
        begin.x += translation.x;
        end.x += translation.x;
        begin.y += translation.y;
        end.y += translation.y;
        _selectedLine.begin = begin;
        _selectedLine.end = end;
        [self setNeedsDisplay];
        [gr setTranslation:CGPointZero inView:self];
    }
    
}

- (void) longPress: (UIGestureRecognizer *) gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        _selectedLine = [self lineAtPoint:point];
        if (_selectedLine) {
            [linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        _selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (void) tap: (UIGestureRecognizer *) gr {
    NSLog(@"tap");
    [linesInProgress removeAllObjects];
    CGPoint point = [gr locationInView:self];
    _selectedLine = [self lineAtPoint:point];
    
    if (_selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 1) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
    }
    
    [self setNeedsDisplay];
}

- (void) deleteLine: (id) sender {
    [completeLines removeObject:_selectedLine];
    [self setNeedsDisplay];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (Line *) lineAtPoint:(CGPoint) p {
    for (Line *line in completeLines) {
        for (float t = 0.0; t < 1.0; t += 0.05) {
            float x = line.begin.x + t * (line.end.x - line.begin.x);
            float y = line.begin.y + t * (line.end.y - line.begin.y);
            float dist = hypotf(p.x - x, p.y - y);
            if (dist < 20.0) {
                return line;
            }
        }
    }
    return nil;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch.tapCount > 1) {
            [self clearAll];
            return;
        }
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        CGPoint loc = [touch locationInView:self];
        Line *newLine = [[Line alloc] init];
        newLine.begin = loc;
        newLine.end = loc;
        [linesInProgress setObject:newLine forKey:key];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        CGPoint loc = [touch locationInView:self];
        Line *line = [linesInProgress objectForKey:key];
        line.end = loc;
        [self setNeedsDisplay];
    }
}

- (void) endTouches:(NSSet *)touches {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        Line *line = [linesInProgress objectForKey:key];
        if (line) {
            [completeLines addObject:line];
            [linesInProgress removeObjectForKey:key];
        }
        [self setNeedsDisplay];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (Line *line in completeLines) {
        if (line == _selectedLine) {
            [[UIColor greenColor] set];
        }
        else {
            [[UIColor blackColor] set];
        }
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        CGContextStrokePath(context);
    }
    
    [[UIColor redColor] set];
    for (NSValue *value in linesInProgress) {
        Line *line = [linesInProgress objectForKey:value];
        CGPoint velocity = [panRecognizer velocityInView:self];
        CGFloat mag = hypotf(velocity.x, velocity.y);
        NSLog(@"%f", mag);
        CGContextSetLineWidth(context, mag / 250.0);
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        CGContextStrokePath(context);
    }
    
}

- (void) clearAll {
    [linesInProgress removeAllObjects];
    [completeLines removeAllObjects];
    [self setNeedsDisplay];
}

@end
