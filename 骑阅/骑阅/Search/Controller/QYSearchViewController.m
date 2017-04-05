//
//  QYSearchViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSearchViewController.h"
#import "QYSearchApiManager.h"
#import "QYSearchView.h"
#import "MBProgressHUD+LLHud.h"
#import "QYAttentionReform.h"
#import "YYBasicTableView.h"
#import "define.h"
#import "QYAttentionViewCell.h"
#import "QYReadLookUserController.h"
#import "QYNavigationController.h"

@interface QYSearchViewController ()<QYSearchActionDelegate,UITableViewDelegate,UITableViewDataSource,QYViewClickProtocol>
@property (nonatomic, strong) QYSearchView *searchView;
@property (nonatomic, strong) QYSearchApiManager *searchApi;
@property (nonatomic, assign) NSUInteger requstId;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) QYAttentionReform *reform;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchArrays;
@end

@implementation QYSearchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setContentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
#pragma mark - click custom 

- (void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - private method
- (void)setContentView {
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(20);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_3y(90));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.top.equalTo(self.searchView.mas_bottom);
    }];
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYAttentionViewCell *searchCell = (QYAttentionViewCell *)cell;
    NSDictionary *info = self.searchArrays[indexPath.row];
    searchCell.info = info[@"result"];
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *info = self.searchArrays[indexPath.row];
    QYUser *user = info[kdata];
    QYReadLookUserController *look = [[QYReadLookUserController alloc] init];
    look.user = user;
    QYNavigationController *navc = [[QYNavigationController alloc] initWithRootViewController:look];
    [self presentViewController:navc animated:YES completion:nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(187);
}
#pragma mark - searchDelegate

- (void)searchStart:(NSInteger)searchId manager:(CTAPIBaseManager *)manager {
    
    self.hud = [MBProgressHUD showMessage:@"搜索中" toView:nil];
    self.requstId = searchId;
}

- (void)searchFailed:(NSInteger)searchId manager:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (searchId == self.requstId) {
        
        [self.serialQueue addOperationWithBlock:^{
           
            [self.searchArrays removeAllObjects];
            self.searchArrays = [manager fetchDataWithReformer:self.reform];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                [self.tableView reloadData];
            }];
        }];
    }

}

- (void)searchSuccess:(NSInteger)searchId manager:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (searchId == self.requstId) {
        
        [self.serialQueue addOperationWithBlock:^{
            
            [self.searchArrays removeAllObjects];
            self.searchArrays = [manager fetchDataWithReformer:self.reform];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.tableView reloadData];
            }];
        }];

    }
}

#pragma mark - setter and getter

- (QYSearchView *)searchView {
    
    if (!_searchView) {
        
        _searchView = [QYSearchView searchViewLogic:self.searchApi];
        _searchView.delegate = self;
       
    }
    return _searchView;
}

- (QYSearchApiManager *)searchApi {
    
    if (!_searchApi) {
        
        _searchApi = [[QYSearchApiManager alloc] init];
        _searchApi.search = self;
    }
    return _searchApi;
}

- (QYAttentionReform *)reform {
    
    if (!_reform) {
        
        _reform = [[QYAttentionReform alloc] init];
    }
    return _reform;
}
- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[QYAttentionViewCell class] forCellReuseIdentifier:@"searchCell"];
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
