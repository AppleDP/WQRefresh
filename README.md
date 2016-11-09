# WQRefresh
上拉加载 + 下拉刷新
<p>
  <img src=' WQRefresh/WQRefresh/EffectGif/Header0_Footer1.gif' alt="Header0_Footer1" title="Header0_Footer1">
  <img src=' WQRefresh/WQRefresh/EffectGif/Header1_Footer0.gif' alt="Header1_Footer0" title="Header1_Footer0">
</p>

# Install
```objective-c
pod 'WQRefresh', '~> 1.0.0'
```

# Usage
## 简单调用
```objective-c
    // 下拉刷新
    self.tableView.headerRefresh = ^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(3.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [weakSelf.tableView stopRefreshingWithMessage:@"刷新成功"
                                                                    type:WQSuccess];
                       });
    };
    // 上拉加载
    self.tableView.footerRefresh = ^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(3.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [weakSelf.tableView stopRefreshingWithMessage:@"加载失败"
                                                                    type:WQFailed];
                       });
    };
```

## 样式设置
```objective-c
    // 结束动画时长
    self.tableView.hiddenDuration = 2.f;
    
    // 下拉刷新样式
    self.tableView.headerRefreshVStyle = WQHeaderRefreshStyle1;
    
    // 上拉刷新样式
    self.tableView.footerRefreshVStyle = WQFooterRefreshStyle1;
    
    // 刷新视图背景色
    self.tableView.refreshViewColor = [UIColor grayColor];
    
    // 图标颜色
    self.tableView.iconColor = [UIColor whiteColor];
    
    // 字体首饰
    self.tableView.fontColor = [UIColor whiteColor];
    
    // 加载视图颜色
    self.tableView.activityColor = [UIColor whiteColor];
```
