//
//  WQDrawIcon.m
//  WQRefresh
//
//  Created by admin on 16/11/7.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQDrawIcon.h"

#define Width CGRectGetWidth(self.frame)
#define Height CGRectGetHeight(self.frame)

@interface WQDrawIcon ()
@end

@implementation WQDrawIcon
- (WQDrawIcon *)initWithFrame:(CGRect)frame
                     drawType:(WQDrawIconType)type {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.type = type;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch (self.type) {
        case WQDrawIconSuccess:{
            [self drawSuccess];
            break;
        }
            
        case WQDrawIconFailue:{
            [self drawFailue];
            break;
        }
            
        default:{
            [self drawArrow];
            break;
        }
    }
}

#pragma mark Setter、Getter
- (void)setIconColor:(UIColor *)iconColor {
    _iconColor = iconColor;
    [self setNeedsDisplay];
}

- (void)setType:(WQDrawIconType)type {
    _type = type;
    [self setNeedsDisplay];
}


#pragma mark 画图
- (void)drawSuccess {
    CGFloat lineWith = 2*MIN(Width, Height)/15;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(7.5*Width/15, 2*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(4.66*Width/15, 2.79*Width/15)
                  controlPoint1: CGPointMake(6.46*Width/15, 2*Width/15)
                  controlPoint2: CGPointMake(5.49*Width/15, 2.29*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(2*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(3.06*Width/15, 3.75*Width/15)
                  controlPoint2: CGPointMake(2*Width/15, 5.5*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 13*Width/15)
                  controlPoint1: CGPointMake(2*Width/15, 10.54*Width/15)
                  controlPoint2: CGPointMake(4.46*Width/15, 13*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(13*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(10.54*Width/15, 13*Width/15)
                  controlPoint2: CGPointMake(13*Width/15, 10.54*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 2*Width/15)
                  controlPoint1: CGPointMake(13*Width/15, 4.46*Width/15)
                  controlPoint2: CGPointMake(10.54*Width/15, 2*Width/15)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(15*Width/15, 7.5*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 15*Width/15)
                  controlPoint1: CGPointMake(15*Width/15, 11.64*Width/15)
                  controlPoint2: CGPointMake(11.64*Width/15, 15*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(0*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(3.36*Width/15, 15*Width/15)
                  controlPoint2: CGPointMake(0*Width/15, 11.64*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(2.94*Width/15, 1.55*Width/15)
                  controlPoint1: CGPointMake(0*Width/15, 5.07*Width/15)
                  controlPoint2: CGPointMake(1.15*Width/15, 2.92*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 0*Width/15)
                  controlPoint1: CGPointMake(4.2*Width/15, 0.58*Width/15)
                  controlPoint2: CGPointMake(5.78*Width/15, 0*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(15*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(11.64*Width/15, 0*Width/15)
                  controlPoint2: CGPointMake(15*Width/15, 3.36*Width/15)];
    [bezierPath closePath];
    [self.iconColor setFill];
    [bezierPath fill];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(4*Width/15, 7*Width/15)];
    [bezier2Path addLineToPoint: CGPointMake(7*Width/15, 10*Width/15)];
    [bezier2Path addLineToPoint: CGPointMake(11*Width/15, 5*Width/15)];
    [self.iconColor setStroke];
    bezier2Path.lineWidth = lineWith;
    [bezier2Path stroke];
}

- (void)drawFailue {
    CGFloat lineWith = 2*MIN(Width, Height)/15;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(7.5*Width/15, 2*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(4.66*Width/15, 2.79*Width/15)
                  controlPoint1: CGPointMake(6.46*Width/15, 2*Width/15)
                  controlPoint2: CGPointMake(5.49*Width/15, 2.29*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(2*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(3.06*Width/15, 3.75*Width/15)
                  controlPoint2: CGPointMake(2*Width/15, 5.5*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 13*Width/15)
                  controlPoint1: CGPointMake(2*Width/15, 10.54*Width/15)
                  controlPoint2: CGPointMake(4.46*Width/15, 13*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(13*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(10.54*Width/15, 13*Width/15)
                  controlPoint2: CGPointMake(13*Width/15, 10.54*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 2*Width/15)
                  controlPoint1: CGPointMake(13*Width/15, 4.46*Width/15)
                  controlPoint2: CGPointMake(10.54*Width/15, 2*Width/15)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(15*Width/15, 7.5*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 15*Width/15)
                  controlPoint1: CGPointMake(15*Width/15, 11.64*Width/15)
                  controlPoint2: CGPointMake(11.64*Width/15, 15*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(0*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(3.36*Width/15, 15*Width/15)
                  controlPoint2: CGPointMake(0*Width/15, 11.64*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(2.94*Width/15, 1.55*Width/15)
                  controlPoint1: CGPointMake(0*Width/15, 5.07*Width/15)
                  controlPoint2: CGPointMake(1.15*Width/15, 2.92*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(7.5*Width/15, 0*Width/15)
                  controlPoint1: CGPointMake(4.2*Width/15, 0.58*Width/15)
                  controlPoint2: CGPointMake(5.78*Width/15, 0*Width/15)];
    [bezierPath addCurveToPoint: CGPointMake(15*Width/15, 7.5*Width/15)
                  controlPoint1: CGPointMake(11.64*Width/15, 0*Width/15)
                  controlPoint2: CGPointMake(15*Width/15, 3.36*Width/15)];
    [bezierPath closePath];
    [self.iconColor setFill];
    [bezierPath fill];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(4*Width/15, 4*Width/15)];
    [bezier2Path addLineToPoint: CGPointMake(11*Width/15, 11*Width/15)];
    [self.iconColor setStroke];
    bezier2Path.lineWidth = lineWith;
    [bezier2Path stroke];
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(11*Width/15, 4*Width/15)];
    [bezier5Path addLineToPoint: CGPointMake(4*Width/15, 11*Width/15)];
    [self.iconColor setStroke];
    bezier5Path.lineWidth = lineWith;
    [bezier5Path stroke];
}

- (void)drawArrow {
    UIBezierPath* darkArrowPath = [UIBezierPath bezierPath];
    [darkArrowPath moveToPoint:CGPointMake(0.53*Width/21, 10.69*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(9.29*Width/21, 19.48*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(10.5*Width/21, 19.99*Height/20)
                     controlPoint1:CGPointMake(9.63*Width/21, 19.82*Height/20)
                     controlPoint2:CGPointMake(10.02*Width/21, 19.99*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(11.73*Width/21, 19.48*Height/20)
                     controlPoint1:CGPointMake(10.96*Width/21, 19.99*Height/20)
                     controlPoint2:CGPointMake(11.37*Width/21, 19.82*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(20.49*Width/21, 10.69*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(21*Width/21, 9.49*Height/20)
                     controlPoint1:CGPointMake(20.83*Width/21, 10.38*Height/20)
                     controlPoint2:CGPointMake(21*Width/21, 9.97*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(20.49*Width/21, 8.25*Height/20)
                     controlPoint1:CGPointMake(21*Width/21, 9.03*Height/20)
                     controlPoint2:CGPointMake(20.83*Width/21, 8.62*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(19.48*Width/21, 7.27*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(18.25*Width/21, 6.76*Height/20)
                     controlPoint1:CGPointMake(19.14*Width/21, 6.93*Height/20)
                     controlPoint2:CGPointMake(18.73*Width/21, 6.76*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(17.04*Width/21, 7.27*Height/20)
                     controlPoint1:CGPointMake(17.79*Width/21, 6.76*Height/20)
                     controlPoint2:CGPointMake(17.38*Width/21, 6.93*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(13.08*Width/21, 11.22*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(13.08*Width/21, 1.74*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(12.58*Width/21, 0.51*Height/20)
                     controlPoint1:CGPointMake(13.08*Width/21, 1.25*Height/20)
                     controlPoint2:CGPointMake(12.91*Width/21, 0.87*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(11.37*Width/21, 0*Height/20)
                     controlPoint1:CGPointMake(12.24*Width/21, 0.17*Height/20)
                     controlPoint2:CGPointMake(11.83*Width/21, 0*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(9.63*Width/21, 0*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(8.42*Width/21, 0.51*Height/20)
                     controlPoint1:CGPointMake(9.17*Width/21, 0*Height/20)
                     controlPoint2:CGPointMake(8.76*Width/21, 0.17*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(7.92*Width/21, 1.74*Height/20)
                     controlPoint1:CGPointMake(8.09*Width/21, 0.87*Height/20)
                     controlPoint2:CGPointMake(7.92*Width/21, 1.25*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(7.92*Width/21, 11.22*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(3.96*Width/21, 7.27*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(2.75*Width/21, 6.76*Height/20)
                     controlPoint1:CGPointMake(3.62*Width/21, 6.93*Height/20)
                     controlPoint2:CGPointMake(3.21*Width/21, 6.76*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(1.52*Width/21, 7.27*Height/20)
                     controlPoint1:CGPointMake(2.27*Width/21, 6.76*Height/20)
                     controlPoint2:CGPointMake(1.86*Width/21, 6.93*Height/20)];
    [darkArrowPath addLineToPoint:CGPointMake(0.53*Width/21, 8.25*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(0*Width/21, 9.49*Height/20)
                     controlPoint1:CGPointMake(0.19*Width/21, 8.59*Height/20)
                     controlPoint2:CGPointMake(0*Width/21, 9*Height/20)];
    [darkArrowPath addCurveToPoint:CGPointMake(0.53*Width/21, 10.69*Height/20)
                     controlPoint1:CGPointMake(0*Width/21, 9.97*Height/20)
                     controlPoint2:CGPointMake(0.19*Width/21, 10.38*Height/20)];
    [darkArrowPath closePath];
    darkArrowPath.miterLimit = 4;
    
    darkArrowPath.usesEvenOddFillRule = YES;
    
    [self.iconColor setFill];
    [darkArrowPath fill];
}

@end


















