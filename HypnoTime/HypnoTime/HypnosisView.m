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
        
        mainLayer = [[CALayer alloc] init];
        mainLayer.bounds = CGRectMake(0, 0, 130.0, 130.0);
        mainLayer.position = CGPointMake(160.0, 100.0);
        
        CALayer *tileLayer = [[CALayer alloc] init];
        tileLayer.position = CGPointMake(CGRectGetMidX(mainLayer.bounds), CGRectGetMidY(mainLayer.bounds));
        tileLayer.bounds = CGRectMake(0, 0, 85.0, 85.0);
        tileLayer.backgroundColor = [UIColor redColor].CGColor;
        tileLayer.cornerRadius = 10.0;
        tileLayer.shadowOffset = CGSizeMake(15.0, 15.0);
        tileLayer.shadowColor = [UIColor blackColor].CGColor;
        tileLayer.shadowOpacity = 1.0;
        tileLayer.opacity = 0.5;
        tileLayer.rasterizationScale = [UIScreen mainScreen].scale;
        tileLayer.zPosition = 0.0;
        tileLayer.shouldRasterize = YES;
        
        CALayer *imageLayer = [[CALayer alloc] init];
        imageLayer.bounds = CGRectMake(0, 0, 50, 50);
        imageLayer.position = tileLayer.position;
        UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];
        imageLayer.contents = (__bridge id) layerImage.CGImage;
        imageLayer.contentsRect = CGRectMake(-0.1, -0.1, 1.2, 1.2);
        imageLayer.contentsGravity = kCAGravityResizeAspect;
        imageLayer.zPosition = 5.0;
        [mainLayer addSublayer:imageLayer];
        
        [mainLayer addSublayer:tileLayer];


        [self.layer addSublayer:mainLayer];
        
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    mainLayer.position = p;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    mainLayer.position = p;
    [CATransaction commit];
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
    
//    CGContextSaveGState(ctx);
//    [[UIColor greenColor] setStroke];
//    CGContextMoveToPoint(ctx, center.x - 50, center.y);
//    CGContextAddLineToPoint(ctx, center.x + 50, center.y);
//    CGContextMoveToPoint(ctx, center.x, center.y - 50);
//    CGContextAddLineToPoint(ctx, center.x, center.y + 50);
//    CGContextStrokePath(ctx);
//    CGContextRestoreGState(ctx);
    
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
