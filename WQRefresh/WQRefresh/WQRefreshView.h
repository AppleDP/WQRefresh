//
//  WQRefreshView.h
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WQFrame.h"
#import "WQDrawIcon.h"

#define sWidth CGRectGetWidth(self.frame)
#define sHeight CGRectGetHeight(self.frame)

@interface WQRefreshView : UIView
@property (nonatomic, weak) UIView *stopIconV;
@property (nonatomic, weak) UILabel *labStopMsg;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, strong) UIColor *activityColor;

- (CGRect)calculateWithString:(NSString *)str
                         font:(UIFont *)font;

- (void)setUpView;
- (void)showAnimation;
- (void)stopAnimation;
- (void)fontColorChange;
- (void)iconColorChange;
- (void)activityColorChange;
- (void)didStopRefreshing:(NSNotification *)sender;
- (void)willStopRefreshing:(NSNotification *)sender;
- (void)didDraggedCanNotRefresh:(NSNotification *)sender;
- (void)didDraggedCanHeaderRefresh:(NSNotification *)sender;
- (void)didDraggedCanFooterRefresh:(NSNotification *)sender;
@end
