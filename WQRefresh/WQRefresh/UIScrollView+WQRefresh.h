//
//  UIScrollView+WQRefresh.h
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQConstant.h"

typedef enum {
    WQInitial,
    WQHeaderRefresh,
    WQFooterRefresh
}WQRefreshType;

typedef enum {
    WQHeaderRefreshStyle0,
    WQHeaderRefreshStyle1
}WQHeaderRefreshStyle;

typedef enum {
    WQFooterRefreshStyle0,
    WQFooterRefreshStyle1
}WQFooterRefreshStyle;

typedef void(^HeaderRefreshHendle)();
typedef void(^FooterRefreshHendle)();

@interface UIScrollView (WQRefresh)
@property (nonatomic, copy) HeaderRefreshHendle headerRefresh;
@property (nonatomic, copy) FooterRefreshHendle footerRefresh;
@property (nonatomic, assign) WQHeaderRefreshStyle headerRefreshVStyle;
@property (nonatomic, assign) WQFooterRefreshStyle footerRefreshVStyle;
@property (nonatomic, assign) WQRefreshType refreshType;
@property (nonatomic, assign) CGFloat hiddenDuration;
@property (nonatomic, strong) UIColor *refreshViewColor;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, strong) UIColor *activityColor;

- (void)stopRefreshingWithMessage:(NSString *)message
                             type:(WQStopType)type;











/******************** 内 部 变 量 ********************/
@property (nonatomic, assign, readonly) BOOL isRefreshing;
@property (nonatomic, assign, readonly) CGFloat lessOffset;
@property (nonatomic, weak, readonly) UIView *headerRefreshV;
@property (nonatomic, weak, readonly) UIView *footerRefreshV;
@end





















