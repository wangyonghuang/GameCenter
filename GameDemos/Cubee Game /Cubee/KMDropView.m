//
//  KMDropView.m
//  Cubee
//
//  Created by 周祺华 on 2016/11/25.
//  Copyright © 2016年 周祺华. All rights reserved.
//

#import "KMDropView.h"

@implementation KMDropView
{
    CGFloat _selfBoundsX;
    CGFloat _selfBoundsY;
    
    CGFloat _selfFrameX;
    CGFloat _selfFrameY;
    CGFloat _selfFrameWidth;
    CGFloat _selfFrameHeight;
    CGFloat _selfFrameSquareWidth;          //!< 如果frame不是正方形，则取短边构造内置正方形
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setupBoundsAndFrame];
    }
    return self;
    
}

- (void)initData
{
    _borderColor = [UIColor blackColor];
    _insideSqureColor = [UIColor whiteColor];
    _type = @"#$%^&*";
}

- (void)setupBoundsAndFrame
{
    _selfBoundsX      = self.bounds.origin.x;
    _selfBoundsY      = self.bounds.origin.y;
    
    _selfFrameX       = self.frame.origin.x;
    _selfFrameY       = self.frame.origin.y;
    _selfFrameWidth   = self.frame.size.width;
    _selfFrameHeight  = self.frame.size.height;
    _selfFrameSquareWidth = (_selfFrameWidth<=_selfFrameHeight)? _selfFrameWidth : _selfFrameHeight;
}



#pragma mark - Property Set Methods
- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(_selfBoundsX, _selfBoundsY)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+_selfFrameSquareWidth, _selfBoundsY)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+_selfFrameSquareWidth, _selfBoundsY+_selfFrameSquareWidth)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX, _selfBoundsY+_selfFrameSquareWidth)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX, _selfBoundsY)];
    
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = _borderColor.CGColor;
    shapeLayer.lineWidth = 1.0f;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)setInsideSqureColor:(UIColor *)insideSqureColor
{
    _insideSqureColor = insideSqureColor;
    
    CGFloat ratio = 0.8;
    CGFloat margin = _selfFrameSquareWidth*(1-ratio)/2;
    CGFloat insideSqureWidth = _selfFrameSquareWidth*ratio;
    
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(_selfBoundsX+margin, _selfBoundsY+margin)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+margin+insideSqureWidth, _selfBoundsY+margin)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+margin+insideSqureWidth, _selfBoundsY+margin+insideSqureWidth)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+margin, _selfBoundsY+margin+insideSqureWidth)];
    [bezierPath addLineToPoint:CGPointMake(_selfBoundsX+margin, _selfBoundsY+margin)];
    
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = _insideSqureColor.CGColor;
    shapeLayer.strokeColor = _insideSqureColor.CGColor;
    shapeLayer.lineWidth = 1.0f;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)setType:(NSString *)type
{
    _type = type;
}

- (void)setPattern:(UIImage *)pattern
{
    // add sth later
}


@end
