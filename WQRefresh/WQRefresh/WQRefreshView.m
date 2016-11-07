//
//  WQRefreshView.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "WQRefreshView.h"
#import "WQConstant.h"

@implementation WQRefreshView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        
        // 添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didStopRefreshing:)
                                                     name:kDidStopRefreshing
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willStopRefreshing:)
                                                     name:kWillStopRefreshing
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didDraggedCanNotRefresh:)
                                                     name:kEndDraggingCanNotRefresh
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didDraggedCanHeaderRefresh:)
                                                     name:kEndDraggingCanHeaderRefresh
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didDraggedCanFooterRefresh:)
                                                     name:kEndDraggingCanFooterRefresh
                                                   object:nil];
        // labStopMsg
        UILabel *labStopMsg = [[UILabel alloc] init];
        labStopMsg.font = [UIFont systemFontOfSize:12];
        labStopMsg.hidden = YES;
        self.labStopMsg = labStopMsg;
        
        // stopIconV
        WQDrawIcon *stopIconV = [[WQDrawIcon alloc] initWithFrame:CGRectMake(0, 0, 15, 15)
                                                         drawType:WQDrawIconSuccess];
        stopIconV.hidden = YES;
        self.stopIconV = stopIconV;
        
        [self addSubview:self.labStopMsg];
        [self addSubview:self.stopIconV];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpView {}
- (void)showAnimation {}
- (void)stopAnimation {}
- (void)fontColorChange {}
- (void)iconColorChange {}
- (void)activityColorChange {}

- (void)didStopRefreshing:(NSNotification *)sender {}
- (void)willStopRefreshing:(NSNotification *)sender {
    NSDictionary *dic = (NSDictionary *)sender.object;
    
    // labStopMsg
    NSString *msg = dic[kStopMessage];
    self.labStopMsg.text = msg;
    
    // stopIconV
    WQStopType type = [(NSNumber *)dic[kStopType] intValue];
    WQDrawIcon *stopIconV = (WQDrawIcon *)self.stopIconV;
    switch (type) {
        case WQSuccess:
            stopIconV.type = WQDrawIconSuccess;
            break;
            
        default:
            stopIconV.type = WQDrawIconFailue;
            break;
    }
    [self updateStopLayout];
}
- (void)didDraggedCanNotRefresh:(NSNotification *)sender {}
- (void)didDraggedCanHeaderRefresh:(NSNotification *)sender {}
- (void)didDraggedCanFooterRefresh:(NSNotification *)sender {}


#pragma mark 私有方法
- (CGRect)calculateWithString:(NSString *)str
                         font:(UIFont *)font {
    CGRect rect = [str boundingRectWithSize:self.frame.size
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName : font}
                                    context:nil];
    return rect;
}

- (void)updateStopLayout {
    CGRect msgRect = [self calculateWithString:self.labStopMsg.text
                                          font:self.labStopMsg.font];
    
    self.stopIconV.x = sWidth/2 - (msgRect.size.width + self.stopIconV.width + 5)/2;
    self.stopIconV.y = sHeight/2 - self.stopIconV.height/2;
    
    self.labStopMsg.frame = msgRect;
    self.labStopMsg.x = CGRectGetMaxX(self.stopIconV.frame) + 5;
    self.labStopMsg.y = sHeight/2 - self.labStopMsg.height/2;
}


#pragma mark Setter、Getter 方法
- (void)setFontColor:(UIColor *)fontColor {
    _fontColor = fontColor;
    self.labStopMsg.textColor = fontColor;
    [self fontColorChange];
}

- (void)setIconColor:(UIColor *)iconColor {
    _iconColor = iconColor;
    WQDrawIcon *stopIconV = (WQDrawIcon *)self.stopIconV;
    stopIconV.iconColor = iconColor;
    [self iconColorChange];
}

- (void)setActivityColor:(UIColor *)activityColor {
    _activityColor = activityColor;
    [self activityColorChange];
}

@end











