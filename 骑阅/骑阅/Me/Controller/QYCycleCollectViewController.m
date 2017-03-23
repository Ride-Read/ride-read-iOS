//
//  QYCycleCollectViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleCollectViewController.h"
#import "QYCycleCollectApiManager.h"
#import "QYCycleCollectReform.h"
#import "YYBasicTableView.h"
#import "QYCycleCollectCellTableViewCell.h"
#import "define.h"

@interface QYCycleCollectViewController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) QYCycleCollectApiManager *collectApi;
@property (nonatomic, strong) QYCycleCollectReform *collectReform;
@property (nonatomic, strong) NSMutableArray *collectArrays;
@end

@implementation QYCycleCollectViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animate {
    
    [super viewWillAppear:animate];
    self.title = @"我的收藏";
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private method
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
}
- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.collectApi loadData];
    }];
}

#pragma mark - CTApiManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.collectApi) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:uid};
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.collectApi) {
        
        if (self.tableView.startFooter) {
            
            NSArray *collects = [self.collectApi fetchDataWithReformer:self.collectReform];
            [self.collectArrays addObjectsFromArray:collects];
            [self.tableView reloadData];
            return;
            
        }
        
        if (self.collectApi.isLoadMore) {
            
            NSArray *collects = [self.collectApi fetchDataWithReformer:self.collectReform];
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (int i = 0; i < collects.count; i++) {
                
                NSIndexPath *index = [NSIndexPath indexPathForRow:self.collectArrays.count + i inSection:0];
                [indexPaths addObject:index];
            }
            
            [self.collectArrays insertObjects:collects atIndexes:[NSIndexSet indexSetWithIndex:self.collectArrays.count]];
            if (collects.count < 10) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.collectApi) {
#warning test ui
        NSArray *collects = [self.collectApi fetchDataWithReformer:self.collectReform];
        [self.collectArrays addObjectsFromArray:collects];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    }
}


#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.collectArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCycleCollectCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colectcell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCycleCollectCellTableViewCell *collectCell = (QYCycleCollectCellTableViewCell *)cell;
    NSDictionary *info = self.collectArrays[indexPath.row];
    collectCell.info = info;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(250);
}


#pragma mark - getter and setter
- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"QYCycleCollectCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"colectcell"];
    }
    return _tableView;
}

- (NSMutableArray *)collectArrays {
    
    if (!_collectArrays) {
        
        _collectArrays = [NSMutableArray array];
    }
    return _collectArrays;
}

- (QYCycleCollectApiManager *)collectApi {
    
    if (!_collectApi) {
        
        _collectApi = [[QYCycleCollectApiManager alloc] init];
        _collectApi.paramSource = self;
        _collectApi.delegate = self;
    }
    return _collectApi;
}

- (QYCycleCollectReform *)collectReform {
    
    if (!_collectReform) {
        _collectReform = [[QYCycleCollectReform alloc] init];
    }
    return _collectReform;
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
