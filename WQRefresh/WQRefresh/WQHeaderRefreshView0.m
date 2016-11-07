//
//  WQHeaderRefreshView0.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQHeaderRefreshView0.h"

#define kWQDATE @"kWQDate"

@interface WQHeaderRefreshView0 ()
@property (nonatomic, weak) UIActivityIndicatorView *activityV;
@property (nonatomic, weak) UIView *arrowV;
@property (nonatomic, weak) UILabel *labLoad;
@property (nonatomic, weak) UILabel *labDate;
@end

@implementation WQHeaderRefreshView0
- (void)setUpView {
    [super setUpView];
    UIActivityIndicatorView *activityV = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    WQDrawIcon *arrowV = [[WQDrawIcon alloc] initWithFrame:CGRectMake(0, 0, 20, 20)
                                                  drawType:WQDrawIconArrow];
    UILabel *labLoad = [[UILabel alloc] init];
    UILabel *labDate = [[UILabel alloc] init];
    
    // activityV
    activityV.color = [UIColor blackColor];
    activityV.hidesWhenStopped = YES;
    self.activityV = activityV;
    
    // arrowV
    arrowV.iconColor = [UIColor blackColor];
    self.arrowV = arrowV;
    
    // labLoad
    labLoad.text = @"下拉刷新";
    labLoad.font = [UIFont systemFontOfSize:12];
    self.labLoad = labLoad;
    
    // labDate
    NSString *dateStr = [[NSUserDefaults standardUserDefaults] stringForKey:kWQDATE];
    if (dateStr.length == 0) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        dateStr = [formatter stringFromDate:date];
    }
    labDate.text = [NSString stringWithFormat:@"上次刷新时间: %@",dateStr];
    labDate.font = [UIFont systemFontOfSize:12];
    self.labDate = labDate;
    
    [self addSubview:self.activityV];
    [self addSubview:self.arrowV];
    [self addSubview:self.labLoad];
    [self addSubview:self.labDate];
    [self updateLayout];
}

- (void)showAnimation {
    [super showAnimation];
    
    self.arrowV.hidden = YES;
    [self.activityV startAnimating];
}

- (void)stopAnimation {
    [super stopAnimation];
    
    self.labLoad.text = @"下拉刷新";
    [self updateLayout];
    self.arrowV.transform = CGAffineTransformIdentity;
}

- (void)fontColorChange {
    [super fontColorChange];
    self.labLoad.textColor = self.fontColor;
    self.labDate.textColor = self.fontColor;
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
    self.labDate.hidden   = NO;
    
    self.labStopMsg.hidden = YES;
    self.stopIconV.hidden  = YES;
    
    // 记录刷新时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    [[NSUserDefaults standardUserDefaults] setObject:dateStr
                                              forKey:kWQDATE];
    self.labDate.text = [NSString stringWithFormat:@"上次刷新时间: %@",dateStr];
}

- (void)willStopRefreshing:(NSNotification *)sender {
    [super willStopRefreshing:sender];
    [self.activityV stopAnimating];
    self.arrowV.hidden    = YES;
    self.labLoad.hidden   = YES;
    self.labDate.hidden   = YES;
    
    self.labStopMsg.hidden = NO;
    self.stopIconV.hidden  = NO;
}

- (void)didDraggedCanNotRefresh:(NSNotification *)sender {
    [super didDraggedCanNotRefresh:sender];
    self.labLoad.text = @"下拉刷新";
    [self updateLayout];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.arrowV.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)didDraggedCanHeaderRefresh:(NSNotification *)sender {
    [super didDraggedCanHeaderRefresh:sender];
    self.labLoad.text = @"释放立即刷新";
    [self updateLayout];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.arrowV.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
                     }
                     completion:^(BOOL finished) {
                     }];
}


# pragma mark 更新控件位置
- (void)updateLayout {
    CGRect loadRect = [self calculateWithString:self.labLoad.text
                                           font:self.labLoad.font];
    CGRect dateRect = [self calculateWithString:self.labDate.text
                                           font:self.labDate.font];
    
    // labLoad
    self.labLoad.frame = loadRect;
    self.labLoad.center = self.center;
    self.labLoad.y = sHeight/2 - (loadRect.size.height + dateRect.size.height + 2.5)/2;
    
    // labDate
    self.labDate.frame = dateRect;
    self.labDate.center = self.center;
    self.labDate.y = CGRectGetMaxY(self.labLoad.frame) + 2.5;
    
    // arrowV、activityV
    CGFloat maxWidth = MAX(loadRect.size.width, dateRect.size.width);
    self.arrowV.x = self.width/2 - maxWidth/2 - self.arrowV.width - 10;
    self.arrowV.y = sHeight/2 - self.arrowV.height/2;
    self.activityV.frame = self.arrowV.frame;
}
@end





