//
//  QYThumbsViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYThumbsViewController.h"
#import "QYShowThumbsApiManager.h"
#import "YYBasicTableView.h"
#import "QYThumbsReform.h"
#import "QYAttentionViewCell.h"
#import "define.h"
#import "QYFromIconLickViewController.h"
#import "QYLookAttentionViewController.h"
#import "QYLoodFansViewController.h"
#import "QYRideMyCycleController.h"

@interface QYThumbsViewController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UITableViewDataSource,UITableViewDelegate,YYBaseicTableViewRefeshDelegate>
@property (nonatomic, strong) QYThumbsReform *reform;
@property (nonatomic, strong) QYShowThumbsApiManager *thumbsApi;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QYThumbsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self loadData];
    self.hud = [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"点赞用户";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customView:(UIView *)customView refresh:(id)data {
    
    [self.tableView reloadData];
}

#pragma mark - private method

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.thumbsApi loadData];
    }];
}

#pragma mark - parmaSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid,kmid:self.mid?:@(-1)};
}

#pragma mark - callback

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    NSArray *resutl = [self.thumbsApi fetchDataWithReformer:self.reform];
    [self.dataArray addObjectsFromArray:resutl];
    [self.tableView reloadData];
    if (!self.tableView.startFooter) {
        
        if (resutl.count >= 20) {
            
            self.tableView.startFooter = YES;
        }
    } else {
        
        [self.tableView.mj_footer endRefreshing];
        if (resutl.count < 20) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
   
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (self.thumbsApi == manager) {
        
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showMessageAutoHide:@"点赞数据获取失败" view:nil];
    }
}

#pragma mark - tableleview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
    cell.ctr = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *a_cell = (QYAttentionViewCell *)cell;
    NSMutableDictionary *info = self.dataArray[indexPath.row];
    a_cell.info = info;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(187);
}


#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *info = self.dataArray[indexPath.row];
    NSNumber *tag = info[@"tag"];
    if (tag.integerValue == 0 || tag.integerValue == 1) {
        
        
        QYFromIconLickViewController *ctr = [[QYFromIconLickViewController alloc] init];
        ctr.user = @{kuid:info[kuid],kusername:info[kusername]}.mutableCopy;
        ctr.title = info[kusername];
        ctr.attentionHandle = ^(NSInteger tag) {
            
            if (tag == 0) {
                
                info[kstatus] = @"attention";
            } else {
                
                info[kstatus] = @"attentioned";
            }
            info[@"tag"] = @(tag);
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        };
        [self.navigationController pushViewController:ctr animated:YES];
        
    } else {
        
        QYRideMyCycleController *ctr = [[QYRideMyCycleController alloc] init];
        ctr.user = @{kuid:info[kuid],kusername:info[kusername]}.mutableCopy;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
}
#pragma mark - refesh

- (void)tableViewFooterRefesh:(YYBasicTableView *)tableView {
    
    [self.thumbsApi loadNext];
}

#pragma mark - getter and setter
- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleFooter];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.frame = self.view.bounds;
        [_tableView registerClass:[QYAttentionViewCell class] forCellReuseIdentifier:@"usercell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64
                                                   , 0);
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (QYShowThumbsApiManager *)thumbsApi {
    
    if (!_thumbsApi) {
        
        _thumbsApi = [[QYShowThumbsApiManager alloc] init];
        _thumbsApi.delegate = self;
        _thumbsApi.paramSource = self;
    }
    return _thumbsApi;
}
- (QYThumbsReform *)reform {
    
    if (!_reform) {
        _reform = [[QYThumbsReform alloc] init];
    }
    return _reform;
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
