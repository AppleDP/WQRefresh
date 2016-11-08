//
//  WQHeaderRefreshView1.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQHeaderRefreshView1.h"

#define itemW 8

@interface WQHeaderRefreshView1 ()
@property (nonatomic, weak) UILabel *labLoad;
@property (nonatomic, weak) UIView *arrowV;
@property (nonatomic, weak) UIView *view0;
@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UIView *view2;
@property (nonatomic, weak) UIView *view3;
@end

@implementation WQHeaderRefreshView1
- (void)setUpView {
    [super setUpView];
    UILabel *labLoad = [[UILabel alloc] init];
    WQDrawIcon *arrowV = [[WQDrawIcon alloc] initWithFrame:CGRectMake(0, 0, 20, 20)
                                                  drawType:WQDrawIconArrow];
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(-itemW, sHeight/2 + 6, itemW, itemW)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(-itemW, sHeight/2 + 6, itemW, itemW)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(-itemW, sHeight/2 + 6, itemW, itemW)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(-itemW, sHeight/2 + 6, itemW, itemW)];
    
    // labLoad
    labLoad.text = @"下拉刷新";
    labLoad.font = [UIFont systemFontOfSize:12];
    self.labLoad = labLoad;
    
    // arrowV
    arrowV.iconColor = [UIColor blackColor];
    self.arrowV = arrowV;
    
    // view0
    view0.layer.cornerRadius = itemW/2;
    view0.backgroundColor = [UIColor blackColor];
    self.view0 = view0;
    
    // view1
    view1.layer.cornerRadius = itemW/2;
    view1.backgroundColor = [UIColor blackColor];
    self.view1 = view1;
    
    // view2
    view2.layer.cornerRadius = itemW/2;
    view2.backgroundColor = [UIColor blackColor];
    self.view2 = view2;
    
    // view3
    view3.layer.cornerRadius = itemW/2;
    view3.backgroundColor = [UIColor blackColor];
    self.view3 = view3;
    
    [self addSubview:self.labLoad];
    [self addSubview:self.arrowV];
    [self addSubview:self.view0];
    [self addSubview:self.view1];
    [self addSubview:self.view2];
    [self addSubview:self.view3];
    
    [self updateLayout];
}

- (void)showAnimation {
    [super showAnimation];
    self.arrowV.hidden = YES;
    self.labLoad.text = @"正在刷新...";
    [self updateLayout];
    [self startAnimation];
}

- (void)stopAnimation {
    [super stopAnimation];
    self.labLoad.text = @"下拉刷新";
    [self updateLayout];
    
    [self.view0.layer removeAllAnimations];
    [self.view1.layer removeAllAnimations];
    [self.view2.layer removeAllAnimations];
    [self.view3.layer removeAllAnimations];
}

- (void)fontColorChange {
    [super fontColorChange];
    self.labLoad.textColor = self.fontColor;
}

- (void)iconColorChange {
    [super iconColorChange];
    WQDrawIcon *arrowV = (WQDrawIcon *)self.arrowV;
    arrowV.iconColor = self.iconColor;
}

- (void)activityColorChange {
    [super activityColorChange];
    self.view0.backgroundColor = self.activityColor;
    self.view1.backgroundColor = self.activityColor;
    self.view2.backgroundColor = self.activityColor;
    self.view3.backgroundColor = self.activityColor;
}

- (void)didStopRefreshing:(NSNotification *)sender {
    [super didStopRefreshing:sender];
    self.arrowV.hidden  = NO;
    self.labLoad.hidden = NO;
    self.view0.hidden   = NO;
    self.view1.hidden   = NO;
    self.view2.hidden   = NO;
    self.view3.hidden   = NO;
    
    self.stopIconV.hidden  = YES;
    self.labStopMsg.hidden = YES;
}

- (void)willStopRefreshing:(NSNotification *)sender {
    [super willStopRefreshing:sender];
    self.arrowV.hidden  = YES;
    self.labLoad.hidden = YES;
    self.view0.hidden   = YES;
    self.view1.hidden   = YES;
    self.view2.hidden   = YES;
    self.view3.hidden   = YES;
    
    self.stopIconV.hidden  = NO;
    self.labStopMsg.hidden = NO;
}

- (void)didDraggedCanNotRefresh:(NSNotification *)sender {
    [super didDraggedCanNotRefresh:sender];
    self.labLoad.text = @"下拉刷新";
    [self updateLayout];
}

- (void)didDraggedCanHeaderRefresh:(NSNotification *)sender {
    [super didDraggedCanHeaderRefresh:sender];
    self.labLoad.text = @"释放立即刷新";
    [self updateLayout];
}


#pragma mark 私有方法
- (void)startAnimation {
    CAKeyframeAnimation *animation0 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation0.values = @[[NSNumber numberWithFloat:self.view0.centerX],
                          [NSNumber numberWithFloat:sWidth/2 + 1.5*itemW],
                          [NSNumber numberWithFloat:sWidth/2 + 1.5*itemW],
                          [NSNumber numberWithFloat:sWidth + itemW]];
    animation0.duration = 4.0;
    animation0.keyTimes = @[@0.0, @0.3, @0.6, @1.0];
    animation0.repeatCount = MAXFLOAT;
    [self.view0.layer addAnimation:animation0
                            forKey:@"animation0"];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation1.values = @[[NSNumber numberWithFloat:self.view1.centerX],
                          [NSNumber numberWithFloat:sWidth/2 + 0.5*itemW],
                          [NSNumber numberWithFloat:sWidth/2 + 0.5*itemW],
                          [NSNumber numberWithFloat:sWidth + itemW]];
    animation1.duration = 4.0;
    animation1.keyTimes = @[@0.05, @0.35, @0.65, @1.0];
    animation1.repeatCount = MAXFLOAT;
    [self.view1.layer addAnimation:animation1
                            forKey:@"animation1"];
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation2.values = @[[NSNumber numberWithFloat:self.view2.centerX],
                          [NSNumber numberWithFloat:sWidth/2 - 0.5*itemW],
                          [NSNumber numberWithFloat:sWidth/2 - 0.5*itemW],
                          [NSNumber numberWithFloat:sWidth + itemW]];
    animation2.duration = 4.0;
    animation2.keyTimes = @[@0.1, @0.4, @0.7, @1.0];
    animation2.repeatCount = MAXFLOAT;
    [self.view2.layer addAnimation:animation2
                            forKey:@"animation2"];
    
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation3.values = @[[NSNumber numberWithFloat:self.view3.centerX],
                          [NSNumber numberWithFloat:sWidth/2 - 1.5*itemW],
                          [NSNumber numberWithFloat:sWidth/2 - 1.5*itemW],
                          [NSNumber numberWithFloat:sWidth + itemW]];
    animation3.duration = 4.0;
    animation3.keyTimes = @[@0.15, @0.45, @0.75, @1.0];
    animation3.repeatCount = MAXFLOAT;
    [self.view3.layer addAnimation:animation3
                            forKey:@"animation3"];
}


- (void)updateLayout {
    CGRect loadRect = [self calculateWithString:self.labLoad.text
                                           font:self.labLoad.font];
    self.labLoad.frame = loadRect;
    self.labLoad.x = sWidth/2 - self.labLoad.width/2;
    self.labLoad.y = sHeight/2 - self.labLoad.height/2 - (self.arrowV.height - self.labLoad.height)/2;
    
    self.arrowV.x = self.labLoad.x - self.arrowV.width - 10;
    self.arrowV.y = CGRectGetMaxY(self.labLoad.frame) - self.arrowV.height;
}
@end












