//
//  QYFriendCycleDetailController.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYFriendCycleDetailController.h"
#import "QYCircleViewCell.h"
#include "YYBasicTableView.h"
#import "define.h"
@interface QYFriendCycleDetailController ()<UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate>
@property (nonatomic, strong) QYCircleViewCell *cell;
@property (nonatomic, strong) YYBasicTableView *tableView;

@end

@implementation QYFriendCycleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- private method 
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
}
#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - setter and getter
- (QYCircleViewCell *)cell {
    
    if (!_cell) {
        _cell = [[QYCircleViewCell alloc] initWithCycleType:QYFriendCycleTypedetail];
        _cell.layout = self.layout;
        _cell.frame = CGRectMake(0, 0, kScreenWidth,self.layout.height + 60 - self.layout.toolHeight);
    }
    return _cell;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleFooter];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.cell;
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
