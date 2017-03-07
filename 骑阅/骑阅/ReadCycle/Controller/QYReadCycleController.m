//
//  QYReadCycleController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadCycleController.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"
#import "QYCycleSelectView.h"
#import "YYBasicTableView.h"
#import "QYCircleViewCell.h"
#import "QYCycleTableHeaderView.h"


@interface QYReadCycleController ()<QYViewClickProtocol,UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate>
@property (nonatomic, strong) QYCycleSelectView *selectView;
@property (nonatomic, strong) YYBasicTableView *tableView;

@end

@implementation QYReadCycleController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavc];
    [self setUpContentView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)setUpContentView {
    
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.tableView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.selectView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
}


/**
 如有回复数据，则创建tableView的头部视图
 */
- (void)createTableViewHeader {
    
    QYCycleTableHeaderView *heardView = [[QYCycleTableHeaderView alloc] init];
    self.tableView.tableHeaderView = heardView;
}
- (void)setNavc {
    
    self.navigationItem.title = @"阅圈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(clickSearchButton:)];
    self.navigationItem.rightBarButtonItem = searchButton;
}


#pragma mark - target action
- (void)clickSearchButton:(UIBarButtonItem *)button {
    
    
}
#pragma mark - ClickCutom delegate

- (void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    MyLog(@"%ld",index);
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma  mark - refesh 

- (void)tableViewFooterRefesh:(YYBasicTableView *)tableView {
    
    
}

#pragma mark - setters and getters

-(QYCycleSelectView *)selectView {
    
    if (!_selectView) {
        
        _selectView = [[QYCycleSelectView alloc] init];
        _selectView.delegate = self;
    }
    return _selectView;
}

-(YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleFooter];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
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
