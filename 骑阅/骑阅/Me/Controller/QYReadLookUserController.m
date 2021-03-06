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
#import "MBProgressHUD+LLHud.h"
#import "QYPictureLookController.h"


@interface QYReadLookUserController ()<YYBaseicTableViewRefeshDelegate,QYReadMeHeaderViewDelegate,QYFriendCycleDelegate>
@property (nonatomic, strong) QYCommentSectionView *sectionView;
@property (nonatomic, strong) QYCycleMessageReform *cycleReform;

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


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    }];
}


#pragma mark - headerView delegate

- (void)clickIcon:(QYReadMeHeaderView *)headerView {
    
    
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
    cell.delegate = self;
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
    detail.type = self.type;
    detail.refresh = ^() {
        
        [self.layoutArray replaceObjectAtIndex:indexPath.row withObject:[QYFriendCycleCellLayout friendStatusCellLayout:layout.status]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
     };
    
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYUserCycleLayout *layout = self.layoutArray[indexPath.row];
    return layout.height;
    
}


#pragma mark - tableview refresh

- (void)tableViewFooterRefesh:(YYBasicTableView *)tableView {
    
    [self.cycleApiManager loadNext];
}


#pragma mark - CTApiManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.cycleApiManager) {
        NSNumber *uid = self.user[kuid];
        NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:cuid?:@(-1),kuser_id:uid?:@(-1),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
    }
    if (manager == self.userApi) {
        
        NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
        NSNumber *uid = self.user[kuid];
        return @{kuid:cuid,kuser_id:uid,ktype:@(2)};
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (manager == self.cycleApiManager) {
        
        if (!self.tableView.startFooter) {
            
            NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
            [self.serialQueue addOperationWithBlock:^{
               
                for (NSDictionary *info in cycles) {
                    
                    QYUserCycleLayout *layout = [QYUserCycleLayout friendStatusCellLayout:info];
                    [self.layoutArray addObject:layout];
                }
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                    if (cycles.count == 20) {
                        
                        self.tableView.startFooter = YES;
                    }
                    [self.tableView reloadData];
                    self.numberView.data = cycles;
                     
                }];
            }];
            return;
            
        }
        
        if (self.cycleApiManager.isLoadMore) {
            
            NSUInteger originCount = self.layoutArray.count;
            NSArray *cycles = [self.cycleApiManager fetchDataWithReformer:self.cycleReform];
            [self.serialQueue addOperationWithBlock:^{
               
                NSMutableArray *indexPaths = [NSMutableArray array];
                QYUserCycleLayout *layout;
                for (int i = 0; i < cycles.count; i++) {
                    
                    NSIndexPath *index = [NSIndexPath indexPathForRow:originCount + i inSection:0];
                    [indexPaths addObject:index];
                    layout = [QYUserCycleLayout friendStatusCellLayout:cycles[i]];
                    [self.layoutArray addObject:layout];
                }
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                    if (cycles.count < 20) {
                    
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        
                        [self.tableView.mj_footer endRefreshing];
                    }
                    
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                    self.numberView.data = self.layoutArray;

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

        if (self.tableView.startFooter) {
            
            [self.tableView.mj_footer endRefreshing];
        }
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
    
    
    [self.headerView anlayseData];
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
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
        
        _headerView = [[QYOtherMapHeaderView alloc] init];
        _headerView.delegate = self;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, cl_caculation_3y(560));
        
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
