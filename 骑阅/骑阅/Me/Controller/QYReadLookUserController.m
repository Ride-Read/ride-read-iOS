//
//  QYReadLookUserController.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadLookUserController.h"
#import "QYShowUserCycleApiManager.h"
#import "QYCircleViewCell.h"
#import "QYUserCycleLayout.h"
#import "QYReadMeHeaderView.h"
#import "YYBasicTableView.h"
#import "QYFriendCycleDetailController.h"
#import "QYCommentSectionView.h"
#import "QYCycleMessageReform.h"
#import "QYFansUserViewController.h"
#import "QYAttentionViewController.h"

@interface QYReadLookUserController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate,QYReadMeHeaderViewDelegate>
@property (nonatomic, strong) QYReadMeHeaderView *headerView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *layoutArray;
@property (nonatomic, strong) QYShowUserCycleApiManager *cycleApiManager;
@property (nonatomic, strong) QYCommentSectionView *sectionView;
@property (nonatomic, strong) QYCycleMessageReform *cycleReform;

@end

@implementation QYReadLookUserController

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
       
        [self.cycleApiManager loadData];
    }];
}
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
}


#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCircleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
    if (!cell) {
        
        cell = [[QYCircleViewCell alloc] initWithCycleType:QYFriendCycleTypeUser];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCircleViewCell *useCell = (QYCircleViewCell *)cell;
    QYUserCycleLayout *layout = self.layoutArray[indexPath.row];
    useCell.layout = layout;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.sectionView;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYReadLookUserController *look = [[QYReadLookUserController alloc] init];
    [self.navigationController pushViewController:look animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYUserCycleLayout *layout = self.layoutArray[indexPath.row];
    return layout.height;
    
}



#pragma mark - CTApiManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.cycleApiManager) {
        NSNumber *uid = self.user.uid;
        return @{kuid:uid};
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.cycleApiManager) {
        
        if (self.tableView.startFooter) {
            
            NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
            [self.serialQueue addOperationWithBlock:^{
               
                for (NSDictionary *info in cycles) {
                    
                    QYUserCycleLayout *layout = [QYUserCycleLayout friendStatusCellLayout:info];
                    [self.layoutArray addObject:layout];
                }
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                    [self.tableView reloadData];
                    
                }];
            }];
            return;
            
        }
        
        if (self.cycleApiManager.isLoadMore) {
            
            NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
            [self.serialQueue addOperationWithBlock:^{
               
                NSMutableArray *indexPaths = [NSMutableArray array];
                QYUserCycleLayout *layout;
                for (int i = 0; i < cycles.count; i++) {
                    
                    NSIndexPath *index = [NSIndexPath indexPathForRow:self.layoutArray.count + i inSection:0];
                    [indexPaths addObject:index];
                    layout = [QYUserCycleLayout friendStatusCellLayout:cycles[i]];
                }
                
                [self.layoutArray addObject:layout];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                    if (cycles.count < 10) {
                    
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        
                        [self.tableView.mj_footer endRefreshing];
                    }
                    
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                }];
                
            }];
        }
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.cycleApiManager) {
#warning test ui
        NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
        [self.serialQueue addOperationWithBlock:^{
            
            for (NSDictionary *info in cycles) {
                
                QYUserCycleLayout *layout = [QYUserCycleLayout friendStatusCellLayout:info];
                [self.layoutArray addObject:layout];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.tableView reloadData];
                
            }];
        }];
        return;
    }
}

#pragma mark - getter and setter

- (QYShowUserCycleApiManager *)cycleApiManager {
    
    if (!_cycleApiManager) {
        
        _cycleApiManager = [[QYShowUserCycleApiManager alloc] init];
        _cycleApiManager.delegate = self;
        _cycleApiManager.paramSource = self;
    }
    return _cycleApiManager;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleFooter];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)layoutArray {
    
    if (!_layoutArray) {
        
        _layoutArray = [NSMutableArray array];
    }
    return _layoutArray;
}

- (QYCommentSectionView *)sectionView {
    
    if (!_sectionView) {
        
        _sectionView = [[QYCommentSectionView alloc] init];
    }
    return _sectionView;
}
- (QYCycleMessageReform *)cycleReform {
    
    if (!_cycleReform) {
        
        _cycleReform = [[QYCycleMessageReform alloc] init];
    }
    return _cycleReform;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
