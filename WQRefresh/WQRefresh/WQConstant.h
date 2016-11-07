//
//  WQConstant.h
//  WQRefresh
//
//  Created by admin on 16/11/7.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#ifndef WQConstant_h
#define WQConstant_h

typedef enum {
    WQSuccess,
    WQFailed
}WQStopType;

static NSString * kActivityColorChange         = @"kActivityColorChange";
static NSString * kIconColorChange             = @"kIconColorChange";
static NSString * kFontColorChange             = @"kFontColorChange";
static NSString * kWillStopRefreshing          = @"kWillStopRefreshing";
static NSString * kDidStopRefreshing           = @"kDidStopRefreshing";
static NSString * kEndDraggingCanHeaderRefresh = @"kEndDraggingCanHeaderRefresh";
static NSString * kEndDraggingCanFooterRefresh = @"kEndDraggingCanFooterRefresh";
static NSString * kEndDraggingCanNotRefresh    = @"kEndDraggingCanNotRefresh";
static NSString * kStopMessage                 = @"kStopMessage";
static NSString * kStopType                    = @"kStopType";

#endif /* WQConstant_h */
