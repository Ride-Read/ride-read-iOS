//
//  QYAttentOrFansViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentOrFansViewController.h"
#import "QYAttentionOrFansApiManager.h"
#import "QYAttentionViewCell.h"
#import "QYAttentionReform.h"
#import "QYReadLookUserController.h"
#import "define.h"

@interface QYAttentOrFansViewController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,YYBaseicTableViewRefeshDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) QYAttentionOrFansApiManager *userApiManager;
@property (nonatomic, strong) QYAttentionReform *attenionReform;

@end

@implementation QYAttentOrFansViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.userApiManager loadData];
    }];
}
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
}
#pragma mark - Publick method
- (NSDictionary *)paramForUserApi {
    
    return nil;
}

#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.userArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *useCell = (QYAttentionViewCell *)cell;
    NSDictionary *info = self.userArrays[indexPath.row];
    useCell.info = info[@"result"];
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYReadLookUserController *look = [[QYReadLookUserController alloc] init];
    NSDictionary *info = self.userArrays[indexPath.row];
    QYUser *user = info[kdata];
    look.user = user;
    [self.navigationController pushViewController:look animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(187);
}

#pragma mark - CTApiManagerParamSource 

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.userApiManager) {
        
        return [self paramForUserApi];
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.userApiManager) {
        
        if (self.tableView.startFooter) {
            
            NSArray *users = [self.userApiManager fetchDataWithReformer:self.attenionReform];
            [self.userArrays addObjectsFromArray:users];
            [self.tableView reloadData];
            return;
            
        }
        
        if (self.userApiManager.isLoadMore) {
            
            NSArray *users = [self.userApiManager fetchDataWithReformer:self.attenionReform];
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (int i = 0; i < users.count; i++) {
                
                NSIndexPath *index = [NSIndexPath indexPathForRow:self.userArrays.count + i inSection:0];
                [indexPaths addObject:index];
            }
            
            [self.userArrays insertObjects:users atIndexes:[NSIndexSet indexSetWithIndex:self.userArrays.count]];
            if (users.count < 10) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.userApiManager) {
#warning test ui
        NSArray *users = [self.userApiManager fetchDataWithReformer:self.attenionReform];
        [self.userArrays addObjectsFromArray:users];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    }
}

#pragma mark - getter and setter

- (QYAttentionOrFansApiManager *)userApiManager {
    
    if (!_userApiManager) {
        
        _userApiManager = [[QYAttentionOrFansApiManager alloc] init];
        _userApiManager.delegate = self;
        _userApiManager.paramSource = self;
    }
    return _userApiManager;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleFooter];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.frame = self.view.bounds;
        [_tableView registerClass:[QYAttentionViewCell class] forCellReuseIdentifier:@"usercell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (QYAttentionReform *)attenionReform {
    
    if (!_attenionReform) {
        
        _attenionReform = [[QYAttentionReform alloc] init];
    }
    return _attenionReform;
}

- (NSMutableArray *)userArrays {
    
    if (!_userArrays) {
        
        _userArrays = [NSMutableArray array];
    }
    return _userArrays;
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
