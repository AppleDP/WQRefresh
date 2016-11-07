//
//  ViewController.m
//  WQRefresh
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 jolimark. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+WQRefresh.h"

@interface ViewController ()<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController
static NSString * const Identifier = @"WQCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:Identifier];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    
    self.tableView.headerRefresh = ^(){
        NSLog(@"刷新");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(3.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [weakSelf.tableView stopRefreshingWithMessage:@"刷新成功"
                                                                    type:WQSuccess];
                       });
    };
    self.tableView.refreshViewColor = [UIColor grayColor];
    self.tableView.iconColor = [UIColor whiteColor];
    self.tableView.fontColor = [UIColor whiteColor];
    self.tableView.activityColor = [UIColor whiteColor];
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"----- %ld -----",indexPath.row];
    return cell;
}

@end










