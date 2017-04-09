//
//  QYReadLookUserController.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadLookUserController.h"
#import "QYCircleViewCell.h"
#import "QYUserCycleLayout.h"
#import "QYFriendCycleDetailController.h"
#import "QYCommentSectionView.h"
#import "QYCycleMessageReform.h"
#import "QYFansUserViewController.h"
#import "QYAttentionViewController.h"
#import "QYDetailCycleLayout.h"
#import "QYCommentNumberView.h"
#import "MBProgressHUD+LLHud.h"


@interface QYReadLookUserController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate,QYReadMeHeaderViewDelegate>
@property (nonatomic, strong) NSMutableArray *layoutArray;
@property (nonatomic, strong) QYCommentSectionView *sectionView;
@property (nonatomic, strong) QYCycleMessageReform *cycleReform;
@property (nonatomic, strong) QYCommentNumberView *numberView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) QYUser *user_info;

@end

@implementation QYReadLookUserController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self loadData];
    self.hud = [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
        
        [self.userApi loadData];
    }];
    [self.serialQueue addOperationWithBlock:^{
       
        [self.cycleApiManager loadData];
    }];
    
}
- (void)setContentView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.attentionAndMessageView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
    }];
    [self.attentionAndMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_3y(130));
    }];}


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
    
    return self.numberView;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYFriendCycleDetailController *detail = [[QYFriendCycleDetailController alloc] init];
    QYFriendCycleCellLayout *layout = self.layoutArray[indexPath.row];
    QYDetailCycleLayout *detailLayout = [QYDetailCycleLayout friendStatusCellLayout:layout.status];
    detail.layout = detailLayout;
    [self.navigationController pushViewController:detail animated:YES];
    
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
        NSNumber *uid = self.user[kuid];
        NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:cuid?:@(-1),kuser_id:uid?:@(-1),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
    }
    if (manager == self.userApi) {
        
        NSNumber *uid = self.user[kuid];
        return @{kuid:uid};
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (manager == self.cycleApiManager) {
        
        if (!self.tableView.startFooter) {
            
            NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
            self.attentionAndMessageView.info = cycles[0];
            [self.serialQueue addOperationWithBlock:^{
               
                for (NSDictionary *info in cycles) {
                    
                    QYUserCycleLayout *layout = [QYUserCycleLayout friendStatusCellLayout:info];
                    [self.layoutArray addObject:layout];
                }
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                    [self.tableView reloadData];
                    self.numberView.data = cycles;
                     
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
    
    if (manager == self.userApi) {
        
       self.user_info = [self.userApi fetchDataWithReformer:self.userReform];
        self.headerView.user = self.user_info;
        self.attentionAndMessageView.user = self.user_info;
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    
    if (manager == self.cycleApiManager) {

        [MBProgressHUD showMessageAutoHide:@"列表加载失败" view:nil];
        return;
    }
    
    if (manager == self.userApi) {
        
        [MBProgressHUD showMessageAutoHide:@"用户信息加载失败" view:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - dataRerfresh 

- (void)customView:(UIView *)customView refresh:(id)data {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.userApi loadData];
    }];
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
        
        _tableView = [[YYBasicTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
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

- (QYCommentNumberView *)numberView {
    
    if (!_numberView) {
        
        _numberView = [QYCommentNumberView loadCommentNumberView];
    }
    return _numberView;
}

- (QYAttentionAndMessageView *)attentionAndMessageView {
    
    if (!_attentionAndMessageView) {
        
        _attentionAndMessageView = [QYAttentionAndMessageView loadAttentionAndMessage];
        _attentionAndMessageView.dataRefresh = self;
    }
    return _attentionAndMessageView;
}

- (QYUserReform *)userReform {
    
    if (!_userReform) {
        
        _userReform = [[QYUserReform alloc] init];
    }
    return _userReform;
}
- (QYRideUserApiManager *)userApi {
    
    if (!_userApi) {
        
        _userApi = [[QYRideUserApiManager alloc] init];
        _userApi.delegate = self;
        _userApi.paramSource = self;
    }
    return _userApi;
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
