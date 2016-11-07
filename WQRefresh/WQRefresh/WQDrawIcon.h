//
//  WQDrawIcon.h
//  WQRefresh
//
//  Created by admin on 16/11/7.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WQDrawIconSuccess,
    WQDrawIconFailue,
    WQDrawIconArrow
}WQDrawIconType;

@interface WQDrawIcon : UIView
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, assign) WQDrawIconType type;

- (WQDrawIcon *)initWithFrame:(CGRect)frame
                     drawType:(WQDrawIconType)type;
@end
