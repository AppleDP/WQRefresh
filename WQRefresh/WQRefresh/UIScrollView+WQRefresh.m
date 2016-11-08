//
//  UIScrollView+WQRefresh.m
//  WQRefresh
//
//  Created by admin on 16/10/11.
//  Copyright © 2016年 SUWQ. All rights reserved.
//

#import <objc/runtime.h>
#import "UIScrollView+WQRefresh.h"
#import "UIView+WQFrame.h"

#import "WQRefreshView.h"
#import "WQHeaderRefreshView0.h"
#import "WQHeaderRefreshView1.h"
#import "WQFooterRefreshView0.h"
#import "WQFooterRefreshView1.h"

#define sBounds self.bounds
#define sFrame self.frame

#define rHeight 44

@implementation UIScrollView (WQRefresh)
#pragma mark 公有方法
static NSString * const WQScrollContentOffset        = @"contentOffset";
static NSString * const WQScrollContentSize          = @"contentSize";
static void * WQContentOffsetContext = &WQContentOffsetContext;
static void * WQContentSizeContext   = &WQContentSizeContext;

- (void)stopRefreshingWithMessage:(NSString *)message
                             type:(WQStopType)type {
    if (!self.isRefreshing) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[kStopMessage] = message;
    dic[kStopType] = [NSNumber numberWithInt:type];
    [[NSNotificationCenter defaultCenter] postNotificationName:kWillStopRefreshing
                                                        object:dic];
    
    WQRefreshView *refreshV;
    CGFloat delay = 0.5;
    if (self.refreshType == WQHeaderRefresh) {
        refreshV = (WQRefreshView *)self.headerRefreshV;
    }else if (self.refreshType == WQFooterRefresh) {
        refreshV = (WQRefreshView *)self.footerRefreshV;
        if (type == WQSuccess) {
            delay = 0.0;
        }else {
            delay = 0.5;
        }
    }
    [refreshV stopAnimation];
    
    [UIView animateWithDuration:self.hiddenDuration
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         UIEdgeInsets contentInset = self.contentInset;
                         if (self.refreshType == WQHeaderRefresh) {
                             self.contentInset = UIEdgeInsetsMake(contentInset.top - rHeight,
                                                                  contentInset.left,
                                                                  contentInset.bottom,
                                                                  contentInset.right);
                         }else if (self.refreshType == WQFooterRefresh) {
                             self.contentInset = UIEdgeInsetsMake(contentInset.top,
                                                                  contentInset.left,
                                                                  contentInset.bottom - rHeight,
                                                                  contentInset.right);
                         }
                     }
                     completion:^(BOOL finished) {
                         self.isRefreshing = !finished;
                         if (finished) {
                             [[NSNotificationCenter defaultCenter] postNotificationName:kDidStopRefreshing
                                                                                 object:message];
                             self.refreshType = WQInitial;
                         }
                     }];
}


#pragma mark 私有方法
- (void)headerPrepare {
    NSAssert(self.superview,
             @">>>>>> 在加入父 View 后才可使用 WQRefresh 刷新，请先将视图加载到父 View <<<<<<");
    
    // 匹配 scrollerView 加入到 UINavigationController 的刷新偏移最小值
    UIViewController *currentVC = [self currentViewController];
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        self.lessOffset = rHeight + 64;
    }else {
        self.lessOffset = rHeight;
    }
    
    // 初始化刷新类型
    self.refreshType = WQInitial;
    
    // 添加拖拽监听
    [self addObserver];
    
    // 默认停止刷新动画时长为 0.5s
    self.hiddenDuration = self.hiddenDuration <= 0.0 ? 0.5 : self.hiddenDuration;
    
    // 添加刷新视图
    self.headerRefreshVStyle = self.headerRefreshVStyle;
}

- (void)footerPrepare {
    NSAssert(self.superview,
             @">>>>>> 在加入父 View 后才可使用 WQRefresh 刷新，请先将视图加载到父 View <<<<<<");
    
    // 初始化刷新类型
    self.refreshType = WQInitial;
    
    // 添加拖拽监听
    [self addObserver];
    
    // 默认停止刷新动画时长为 0.5s
    self.hiddenDuration = self.hiddenDuration <= 0.0 ? 0.5 : self.hiddenDuration;
    
    // 添加刷新视图
    self.footerRefreshVStyle = self.footerRefreshVStyle;
}

// 添加值监听
- (void)addObserver {
    if (![self observerKeyPath:WQScrollContentOffset]) {
        [self addObserver:self
               forKeyPath:WQScrollContentOffset
                  options:NSKeyValueObservingOptionNew
                  context:WQContentOffsetContext];
    }
    if (![self observerKeyPath:WQScrollContentSize]) {
        [self addObserver:self
               forKeyPath:WQScrollContentSize
                  options:NSKeyValueObservingOptionNew
                  context:WQContentSizeContext];
    }
    
}

// 移除监听
- (void)removeObserver {
    if ([self observerKeyPath:WQScrollContentOffset]) {
        [self removeObserver:self
                  forKeyPath:WQScrollContentOffset
                     context:WQContentOffsetContext];
    }
    if ([self observerKeyPath:WQScrollContentSize]) {
        [self removeObserver:self
                  forKeyPath:WQScrollContentSize
                     context:WQContentSizeContext];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// keyPath 是否已在监听队列中
- (BOOL)observerKeyPath:(NSString *)key
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath]) {
            return YES;
        }
    }
    return NO;
}

// 获得当前窗口 controller
- (UIViewController *)currentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma mark 系统方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if (context == WQContentOffsetContext) {
        CGPoint contentOffset = [(NSValue *)change[@"new"] CGPointValue];
        CGFloat offsetY = contentOffset.y;
        if (!self.isDragging) {
            // 下拉值 > 刷新最小距离,开始刷新
            if (!self.isRefreshing &&
                self.refreshType == WQHeaderRefresh &&
                self.headerRefreshV) {
                self.isRefreshing = YES;
                UIEdgeInsets contentInset = self.contentInset;
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.contentOffset = CGPointMake(contentOffset.x, -self.lessOffset);
                                     self.contentInset = UIEdgeInsetsMake(contentInset.top + rHeight,
                                                                          contentInset.left,
                                                                          contentInset.bottom,
                                                                          contentInset.right);
                                 }
                                 completion:^(BOOL finished) {
                                 }];
                WQRefreshView *refreshView = (WQRefreshView *)self.headerRefreshV;
                [refreshView showAnimation];
                if (self.headerRefresh) {
                    dispatch_async(dispatch_get_global_queue(0, 0),
                                   self.headerRefresh);
                }
            }else if (!self.isRefreshing &&
                      self.refreshType == WQFooterRefresh &&
                      self.footerRefreshV) {
                // 上拉值 > 刷新最小距离
                self.isRefreshing = YES;
                UIEdgeInsets contentInset = self.contentInset;
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.contentOffset = CGPointMake(contentOffset.x,
                                                                      self.contentSize.height - self.height + rHeight);
                                     self.contentInset = UIEdgeInsetsMake(contentInset.top,
                                                                          contentInset.left,
                                                                          contentInset.bottom + rHeight,
                                                                          contentInset.right);
                                 }
                                 completion:^(BOOL finished) {
                                 }];
                WQRefreshView *refreshView = (WQRefreshView *)self.footerRefreshV;
                [refreshView showAnimation];
                if (self.footerRefresh) {
                    dispatch_async(dispatch_get_global_queue(0, 0),
                                   self.footerRefresh);
                }
            }
        }
        if (self.isRefreshing) {
            // 正在刷新时不可更改刷新类型
            return;
        }
        if (offsetY < -self.lessOffset) {
            self.refreshType = WQHeaderRefresh;
            
            // 松开手时可以下拉刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:kEndDraggingCanHeaderRefresh
                                                                object:@{@"contentOffset" : [NSValue valueWithCGPoint:contentOffset],
                                                                         @"contentSize"   : [NSValue valueWithCGSize:self.contentSize],
                                                                         @"frame"         : [NSValue valueWithCGRect:self.frame]}];
        }else if (offsetY > self.contentSize.height - self.height + rHeight) {
            self.refreshType = WQFooterRefresh;
            
            // 松开手时可以上拉刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:kEndDraggingCanFooterRefresh
                                                                object:@{@"contentOffset" : [NSValue valueWithCGPoint:contentOffset],
                                                                         @"contentSize"   : [NSValue valueWithCGSize:self.contentSize],
                                                                         @"frame"         : [NSValue valueWithCGRect:self.frame]}];
        }else {
            self.refreshType = WQInitial;
            
            // 松开手时不可以刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:kEndDraggingCanNotRefresh
                                                                object:@{@"contentOffset" : [NSValue valueWithCGPoint:contentOffset],
                                                                         @"contentSize"   : [NSValue valueWithCGSize:self.contentSize],
                                                                         @"frame"         : [NSValue valueWithCGRect:self.frame]}];
        }
    }else if (context == WQContentSizeContext) {
        CGSize contentSize = [(NSValue *)change[@"new"] CGSizeValue];
        self.footerRefreshV.y = contentSize.height;
    }
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self removeObserver];
    if (self.headerRefresh != nil) {
        self.headerRefresh = nil;
    }
    if (self.footerRefresh != nil) {
        self.footerRefresh = nil;
    }
}


#pragma mark 分类属性值设置
static const void *refreshTypeKey         = &refreshTypeKey;
static const void *activityColorKey       = &activityColorKey;
static const void *fontColorKey           = &fontColorKey;
static const void *iconColorKey           = &iconColorKey;
static const void *refreshViewColorKey    = &refreshViewColorKey;
static const void *headerRefreshVStyleKey = &headerRefreshVStyleKey;
static const void *footerRefreshVStyleKey = &footerRefreshVStyleKey;
static const void *lessOffsetKey          = &lessOffsetKey;
static const void *headerRefreshVKey      = &headerRefreshVKey;
static const void *footerRefreshVKey      = &footerRefreshVKey;
static const void *isRefreshingKey        = &isRefreshingKey;
static const void *headerRefreshKey       = &headerRefreshKey;
static const void *footerRefreshKey       = &footerRefreshKey;
static const void *hiddenDurationKey      = &hiddenDurationKey;

// headerRefresh
- (void)setHeaderRefresh:(HeaderRefreshHendle)headerRefresh {
    if (self.headerRefresh == nil) {
        [self headerPrepare];
    }
    objc_setAssociatedObject(self,
                             headerRefreshKey,
                             headerRefresh,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (HeaderRefreshHendle)headerRefresh {
    return objc_getAssociatedObject(self,
                                    headerRefreshKey);
}

// footerRefresh
- (void)setFooterRefresh:(FooterRefreshHendle)footerRefresh {
    if (self.footerRefresh == nil) {
        [self footerPrepare];
    }
    objc_setAssociatedObject(self,
                             footerRefreshKey,
                             footerRefresh,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (FooterRefreshHendle)footerRefresh {
    return objc_getAssociatedObject(self,
                                    footerRefreshKey);
}

// lessOffset
- (void)setLessOffset:(CGFloat)lessOffset {
    objc_setAssociatedObject(self,
                             lessOffsetKey,
                             [NSNumber numberWithFloat:lessOffset],
                             OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)lessOffset {
    NSNumber *offset = objc_getAssociatedObject(self,
                                                lessOffsetKey);
    return [offset floatValue];
}

// headerRefreshV
- (void)setHeaderRefreshV:(UIView *)headerRefreshV {
    objc_setAssociatedObject(self,
                             headerRefreshVKey,
                             headerRefreshV,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)headerRefreshV {
    return objc_getAssociatedObject(self,
                                    headerRefreshVKey);
}

// footerRefreshV
- (void)setFooterRefreshV:(UIView *)footerRefreshV {
    objc_setAssociatedObject(self,
                             footerRefreshVKey,
                             footerRefreshV,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)footerRefreshV {
    return objc_getAssociatedObject(self,
                                    footerRefreshVKey);
}

// isRefreshing
- (void)setIsRefreshing:(BOOL)isRefreshing {
    objc_setAssociatedObject(self,
                             isRefreshingKey,
                             [NSNumber numberWithBool:isRefreshing],
                             OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isRefreshing {
    NSNumber *isRefreshing = objc_getAssociatedObject(self,
                                                      isRefreshingKey);
    return [isRefreshing boolValue];
}

// hiddenDuration
- (void)setHiddenDuration:(CGFloat)hiddenDuration {
    objc_setAssociatedObject(self,
                             hiddenDurationKey,
                             [NSNumber numberWithFloat:hiddenDuration],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)hiddenDuration {
    NSNumber *hiddenDuration = objc_getAssociatedObject(self,
                                                        hiddenDurationKey);
    return [hiddenDuration floatValue];
}

// headeRefreshVStyle
- (void)setHeaderRefreshVStyle:(WQHeaderRefreshStyle)headerRerfreshVStyle {
    objc_setAssociatedObject(self,
                             headerRefreshVStyleKey,
                             [NSNumber numberWithInt:headerRerfreshVStyle],
                             OBJC_ASSOCIATION_ASSIGN);
    WQRefreshView *refreshV;
    [self.headerRefreshV removeFromSuperview];
    switch (self.headerRefreshVStyle) {
        case WQHeaderRefreshStyle0:{
            refreshV = [[WQHeaderRefreshView0 alloc] initWithFrame:CGRectMake(sBounds.origin.x,
                                                                        - rHeight,
                                                                        sBounds.size.width,
                                                                        rHeight)];
            break;
        }
        case WQHeaderRefreshStyle1:{
            refreshV = [[WQHeaderRefreshView1 alloc] initWithFrame:CGRectMake(sBounds.origin.x,
                                                                        - rHeight,
                                                                        sBounds.size.width,
                                                                        rHeight)];
            break;
        }
        default:
            break;
    }
    refreshV.fontColor = self.fontColor == nil ? [UIColor blackColor] : self.fontColor;
    refreshV.iconColor = self.iconColor == nil ? [UIColor blackColor] : self.iconColor;
    refreshV.backgroundColor = self.refreshViewColor == nil ? [UIColor clearColor] : self.refreshViewColor;
    refreshV.activityColor = self.activityColor == nil ? [UIColor blackColor] : self.activityColor;
    self.headerRefreshV = refreshV;
    [self addSubview:self.headerRefreshV];
}
- (WQHeaderRefreshStyle)headerRefreshVStyle {
    NSNumber *style = objc_getAssociatedObject(self,
                                               headerRefreshVStyleKey);
    return [style intValue];
}

// footerRefreshVStyle
- (void)setFooterRefreshVStyle:(WQFooterRefreshStyle)footerRefreshVStyle {
    objc_setAssociatedObject(self,
                             footerRefreshVStyleKey,
                             [NSNumber numberWithInt:footerRefreshVStyle],
                             OBJC_ASSOCIATION_ASSIGN);
    WQRefreshView *refreshV;
    [self.footerRefreshV removeFromSuperview];
    switch (self.footerRefreshVStyle) {
        case WQFooterRefreshStyle0:{
            refreshV = [[WQFooterRefreshView0 alloc] initWithFrame:CGRectMake(sBounds.origin.x,
                                                                              - rHeight,
                                                                              sBounds.size.width,
                                                                              rHeight)];
            break;
        }
        case WQFooterRefreshStyle1:{
            refreshV = [[WQFooterRefreshView1 alloc] initWithFrame:CGRectMake(sBounds.origin.x,
                                                                              - rHeight,
                                                                              sBounds.size.width,
                                                                              rHeight)];
            break;
        }
        default:
            break;
    }
    refreshV.fontColor = self.fontColor == nil ? [UIColor blackColor] : self.fontColor;
    refreshV.iconColor = self.iconColor == nil ? [UIColor blackColor] : self.iconColor;
    refreshV.backgroundColor = self.refreshViewColor == nil ? [UIColor clearColor] : self.refreshViewColor;
    refreshV.activityColor = self.activityColor == nil ? [UIColor blackColor] : self.activityColor;
    self.footerRefreshV = refreshV;
    [self addSubview:self.footerRefreshV];
}
- (WQFooterRefreshStyle)footerRefreshVStyle {
    NSNumber *style = objc_getAssociatedObject(self,
                                               footerRefreshVStyleKey);
    return [style intValue];
}

// refreshViewColor
- (void)setRefreshViewColor:(UIColor *)refreshViewColor {
    objc_setAssociatedObject(self,
                             refreshViewColorKey,
                             refreshViewColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.headerRefreshV) {
        self.headerRefreshV.backgroundColor = refreshViewColor;
    }
    
    if (self.footerRefreshV) {
        self.footerRefreshV.backgroundColor = refreshViewColor;
    }
}
- (UIColor *)refreshViewColor {
    UIColor *color = objc_getAssociatedObject(self,
                                              refreshViewColorKey);
    return color;
}

// fontColor
- (void)setFontColor:(UIColor *)fontColor {
    objc_setAssociatedObject(self,
                             fontColorKey,
                             fontColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.footerRefreshV) {
        WQRefreshView *footerRefreshV = (WQRefreshView *)self.footerRefreshV;
        footerRefreshV.fontColor = fontColor;
    }
    if (self.headerRefreshV) {
        WQRefreshView *headerRefreshV = (WQRefreshView *)self.headerRefreshV;
        headerRefreshV.fontColor = fontColor;
    }
    
}
- (UIColor *)fontColor {
    return objc_getAssociatedObject(self,
                                    fontColorKey);
}

// iconColor
- (void)setIconColor:(UIColor *)iconColor {
    objc_setAssociatedObject(self,
                             iconColorKey,
                             iconColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.footerRefreshV) {
        WQRefreshView *footerRefreshV = (WQRefreshView *)self.footerRefreshV;
        footerRefreshV.iconColor = iconColor;
    }
    if (self.headerRefreshV) {
        WQRefreshView *headerRefreshV = (WQRefreshView *)self.headerRefreshV;
        headerRefreshV.iconColor = iconColor;
    }
    
}
- (UIColor *)iconColor {
    return objc_getAssociatedObject(self,
                                    iconColorKey);
}

// activityColor
- (void)setActivityColor:(UIColor *)activityColor {
    objc_setAssociatedObject(self,
                             activityColorKey,
                             activityColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.footerRefreshV) {
        WQRefreshView *footerRefreshV = (WQRefreshView *)self.footerRefreshV;
        footerRefreshV.activityColor = activityColor;
    }
    if (self.headerRefreshV) {
        WQRefreshView *headerRefreshV = (WQRefreshView *)self.headerRefreshV;
        headerRefreshV.activityColor = activityColor;
    }
}
- (UIColor *)activityColor {
    return objc_getAssociatedObject(self,
                                    activityColorKey);
}

// refreshType
- (void)setRefreshType:(WQRefreshType)refreshType {
    objc_setAssociatedObject(self,
                             refreshTypeKey,
                             [NSNumber numberWithInt:refreshType],
                             OBJC_ASSOCIATION_ASSIGN);
}
- (WQRefreshType)refreshType {
    NSNumber *type = objc_getAssociatedObject(self,
                                              refreshTypeKey);
    return [type intValue];
}

@end






