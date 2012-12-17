//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Jack Flintermann on 11/6/12.
//  Copyright (c) 2012 Jack Flintermann. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        circleColor = [UIColor lightGrayColor];
        // Initialization code
    }
    return self;
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        circleColor = [UIColor redColor];
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGFloat maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    CGContextSetLineWidth(ctx, 10);
    [circleColor setStroke];
    for(CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0, M_PI * 2, YES);
        CGContextStrokePath(ctx);
    }
    
    CGContextSaveGState(ctx);
    [[UIColor greenColor] setStroke];
    CGContextMoveToPoint(ctx, center.x - 50, center.y);
    CGContextAddLineToPoint(ctx, center.x + 50, center.y);
    CGContextMoveToPoint(ctx, center.x, center.y - 50);
    CGContextAddLineToPoint(ctx, center.x, center.y + 50);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
    
    NSString *text = @"You are getting sleepy";
    CGRect textRect;
    UIFont *font = [UIFont systemFontOfSize:28];
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = (bounds.size.width - textRect.size.width) / 2.0;
    textRect.origin.y = textRect.size.height + 15;
    [[UIColor blackColor] setFill];
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef gray = [UIColor darkGrayColor].CGColor;
    CGContextSetShadowWithColor(ctx, offset, 2.0, gray);
    [text drawInRect:textRect withFont:font];

}


@end
