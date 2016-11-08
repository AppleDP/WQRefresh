//
//  WQFooterRefreshView0.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQFooterRefreshView0.h"

#define itemW 10

@interface WQFooterRefreshView0 ()
@property (nonatomic, weak) UIView *view0;
@property (nonatomic, weak) UIView *view1;
@end

@implementation WQFooterRefreshView0
- (void)setUpView {
    [super setUpView];
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(sWidth/2 - itemW,
                                                             sHeight/2 - itemW/2,
                                                             itemW,
                                                             itemW)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(sWidth/2,
                                                             sHeight/2 - itemW/2,
                                                             itemW,
                                                             itemW)];
    
    // view0
    view0.backgroundColor = [UIColor blackColor];
    view0.layer.cornerRadius = itemW/2;
    self.view0 = view0;
    
    // view1
    view1.backgroundColor = [UIColor blackColor];
    view1.layer.cornerRadius = itemW/2;
    self.view1 = view1;
    
    [self addSubview:self.view0];
    [self addSubview:self.view1];
}

- (void)showAnimation {
    [super showAnimation];
    [self startAnimation];
}

- (void)stopAnimation {
    [super stopAnimation];
    
    self.view0.x = sWidth/2 - itemW;
    self.view1.x = sWidth/2;
    [self.view0.layer removeAllAnimations];
    [self.view1.layer removeAllAnimations];
}

- (void)fontColorChange {
    [super fontColorChange];
}

- (void)iconColorChange {
    [super iconColorChange];
}

- (void)activityColorChange {
    [super activityColorChange];
    self.view0.backgroundColor = self.activityColor;
    self.view1.backgroundColor = self.activityColor;
}

- (void)didStopRefreshing:(NSNotification *)sender {
    [super didStopRefreshing:sender];
    self.view0.hidden = NO;
    self.view1.hidden = NO;
    
    self.labStopMsg.hidden = YES;
    self.stopIconV.hidden  = YES;
}

- (void)willStopRefreshing:(NSNotification *)sender {
    [super willStopRefreshing:sender];
    self.view0.hidden = YES;
    self.view1.hidden = YES;
    
    self.labStopMsg.hidden = NO;
    self.stopIconV.hidden  = NO;
}

- (void)didDraggedCanNotRefresh:(NSNotification *)sender {
    [super didDraggedCanNotRefresh:sender];
    NSDictionary *dic = sender.object;
    CGSize contentSize = [(NSValue *)dic[@"contentSize"] CGSizeValue];
    CGPoint contentOffset = [(NSValue *)dic[@"contentOffset"] CGPointValue];
    CGRect frame = [(NSValue *)dic[@"frame"] CGRectValue];
    if (contentOffset.y + frame.size.height - contentSize.height > 0) {
        self.view0.x = sWidth/2 - itemW - 2*itemW*(contentOffset.y + frame.size.height - contentSize.height)/sHeight;
        self.view1.x = sWidth/2 + 2*itemW*(contentOffset.y + frame.size.height - contentSize.height)/sHeight;
    }
}

- (void)didDraggedCanFooterRefresh:(NSNotification *)sender {
    [super didDraggedCanFooterRefresh:sender];
}

#pragma mark 私有方法
- (void)startAnimation {
    CABasicAnimation *animation0 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation0.fromValue = [NSNumber numberWithFloat:self.view0.centerX];
    animation0.toValue = [NSNumber numberWithFloat:sWidth/2 - itemW/2];
    animation0.duration = 0.5;
    animation0.repeatCount = MAXFLOAT;
    animation0.autoreverses = YES;
    [self.view0.layer addAnimation:animation0
                            forKey:@"animation0"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation1.fromValue = [NSNumber numberWithFloat:self.view1.centerX];
    animation1.toValue = [NSNumber numberWithFloat:sWidth/2 + itemW/2];
    animation1.duration = 0.5;
    animation1.repeatCount = MAXFLOAT;
    animation1.autoreverses = YES;
    [self.view1.layer addAnimation:animation1
                            forKey:@"animation1"];    
}
@end







