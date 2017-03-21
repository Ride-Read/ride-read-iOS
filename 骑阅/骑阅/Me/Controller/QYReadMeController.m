//
//  QYReadMeController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadMeController.h"
#import "QYReadMeHeaderView.h"
#import "YYBasicTableView.h"
#import "define.h"
#import "QYPersonalDataViewController.h"
#import "QYAttentionViewController.h"
#import "QYFansUserViewController.h"

@interface QYReadMeController ()<UITableViewDelegate,UITableViewDataSource,QYReadMeHeaderViewDelegate>

@property (nonatomic, strong) QYReadMeHeaderView *headerView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@end

@implementation QYReadMeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}
- (void)setNavc {
    
    self.title = @"我的";
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

#pragma mark - headerView delegate

- (void)clickIcon:(QYReadMeHeaderView *)headerView {
    
    QYPersonalDataViewController *person = [[QYPersonalDataViewController alloc] init];
    QYUser *user = [CTAppContext sharedInstance].currentUser;
    person.user = user;
    [self.navigationController pushViewController:person animated:YES];
}
- (void)clickAttentionButton:(QYReadMeHeaderView *)headerView {
    
    QYAttentionViewController *attention = [[QYAttentionViewController alloc] init];
    [self.navigationController pushViewController:attention animated:YES];
}

- (void)clickFansButton:(QYReadMeHeaderView *)headerView {
    
    QYFansUserViewController *attention = [[QYFansUserViewController alloc] init];
    [self.navigationController pushViewController:attention animated:YES];

}
#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mecell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - setter and getter
- (QYReadMeHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[QYReadMeHeaderView alloc] init];
        _headerView.delegate = self;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 270);
    }
    return _headerView;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mecell"];
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
