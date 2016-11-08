//
//  WQFooterRefreshView1.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQFooterRefreshView1.h"

@interface WQFooterRefreshView1 ()
@property (nonatomic, weak) UIActivityIndicatorView *activityV;
@property (nonatomic, weak) UIView *arrowV;
@property (nonatomic, weak) UILabel *labLoad;
@end

@implementation WQFooterRefreshView1
- (void)setUpView {
    [super setUpView];
    UIActivityIndicatorView *activityV = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    WQDrawIcon *arrowV = [[WQDrawIcon alloc] initWithFrame:CGRectMake(0, 0, 20, 20)
                                                  drawType:WQDrawIconArrow];
    UILabel *labLoad = [[UILabel alloc] init];
    
    // activityV
    activityV.color = [UIColor blackColor];
    activityV.hidesWhenStopped = YES;
    self.activityV = activityV;
    
    // arrowV
    self.arrowV = arrowV;
    self.arrowV.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    
    // labLoad
    labLoad.text = @"上拉加载更多";
    labLoad.font = [UIFont systemFontOfSize:12];
    self.labLoad = labLoad;
    
    [self addSubview:self.activityV];
    [self addSubview:self.arrowV];
    [self addSubview:self.labLoad];
    [self updateLayout];
}

- (void)showAnimation {
    [super showAnimation];
    self.labLoad.text = @"正在加载...";
    [self updateLayout];
    [self.activityV startAnimating];
    self.arrowV.hidden = YES;
}

- (void)stopAnimation {
    [super stopAnimation];
    [self.activityV stopAnimating];
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
    self.activityV.color = self.activityColor;
}

- (void)didStopRefreshing:(NSNotification *)sender {
    [super didStopRefreshing:sender];
    self.arrowV.hidden    = NO;
    self.labLoad.hidden   = NO;
    
    self.stopIconV.hidden  = YES;
    self.labStopMsg.hidden = YES;
}

- (void)willStopRefreshing:(NSNotification *)sender {
    [super willStopRefreshing:sender];
    self.arrowV.hidden    = YES;
    self.labLoad.hidden   = YES;
    
    self.stopIconV.hidden  = NO;
    self.labStopMsg.hidden = NO;
}

- (void)didDraggedCanNotRefresh:(NSNotification *)sender {
    [super didDraggedCanNotRefresh:sender];
    self.labLoad.text = @"上拉加载更多";
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.arrowV.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
                     }
                     completion:^(BOOL finished) {
                     }];
    [self updateLayout];
}

- (void)didDraggedCanFooterRefresh:(NSNotification *)sender {
    [super didDraggedCanFooterRefresh:sender];
    self.labLoad.text = @"释放立即加载";
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.arrowV.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                     }];
    [self updateLayout];
}


#pragma mark 更新控件位置
- (void)updateLayout {
    CGRect loadRect = [self calculateWithString:self.labLoad.text
                                           font:self.labLoad.font];
    self.labLoad.frame = loadRect;
    self.labLoad.x = sWidth/2 - self.labLoad.width/2 + 10;
    self.labLoad.y = sHeight/2 - self.labLoad.height/2;
    
    self.arrowV.x = self.labLoad.x - self.arrowV.width - 10;
    self.arrowV.y = sHeight/2 - self.arrowV.height/2;
    self.activityV.frame = self.arrowV.frame;
}
@end









