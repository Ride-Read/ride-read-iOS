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
#import "QYFriendCycleCellLayout.h"
#import "QYReadFriendCycleApiManager.h"
#import "QYFriendCycleDetailController.h"
#import "QYDetailCycleLayout.h"
#import "QYHomeTabBarViewController.h"
#import "QYPictureLookView.h"
#import "QYUserCycleLayout.h"
#import "QYCycleMessageReform.h"
#import "QYSearchViewController.h"
#import "MBProgressHUD+LLHud.h"

@interface QYReadCycleController ()<QYViewClickProtocol,UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,QYFriendCycleDelegate>
@property (nonatomic, strong) QYCycleSelectView *selectView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *layoutArray;
@property (nonatomic, strong) NSMutableArray *attentArray;
@property (nonatomic, strong) QYReadFriendCycleApiManager *friendCycleApi;
@property (nonatomic, strong) QYCycleMessageReform *cycleReform;
@property (nonatomic, assign) NSUInteger type;

@end

@implementation QYReadCycleController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    MyLog(@"%@",path);
    self.type = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpContentView];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attentionSuccess:) name:kAttetionSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unAttentionSuccess:) name:kUnAtteionSuccess object:nil];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavc];
 
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - notifation

- (void)attentionSuccess:(NSNotification *)info {
    

    [self.serialQueue addOperationWithBlock:^{
       
        [self.layoutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            QYCycleBasicLayout *layout = obj;
            NSMutableDictionary *dict = layout.status;
            NSNumber *uid = dict[kuid];
            NSNumber *noti_id = info.userInfo[kuid];
            if (uid.integerValue == noti_id.integerValue) {
                
                dict[kstatus] = @"attentioned";
                dict[@"tag"] = @"1";
            }
        }];
    }];
}

- (void)unAttentionSuccess:(NSNotification *)info {
    
  
    [self.serialQueue addOperationWithBlock:^{
        
        [self.layoutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            QYCycleBasicLayout *layout = obj;
            NSMutableDictionary *dict = layout.status;
            NSNumber *uid = dict[kuid];
            NSNumber *noti_id = info.userInfo[kuid];
            if (uid.integerValue == noti_id.integerValue) {
                
                dict[kstatus] = @"attention";
                dict[@"tag"] = @"0";
            }
        }];
    }];

}

#pragma mark - CTAPIManagParamSource 
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid?:@(-1),ktype:@(self.type),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
}

#pragma mark - CTAPIManagerCallback
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    

    if (manager == self.friendCycleApi) {
        
        [MBProgressHUD showMessageAutoHide:@"阅圈获取失败" view:self.view];
    }
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [self.serialQueue addOperationWithBlock:^{
        
        NSUInteger originCount = self.layoutArray.count;
        NSArray *cycles = [self.friendCycleApi fetchDataWithReformer:self.cycleReform];
        for (NSDictionary *info in cycles) {
            
            QYFriendCycleCellLayout *layout = [QYFriendCycleCellLayout friendStatusCellLayout:info];
            [self.layoutArray addObject:layout];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if (!self.tableView.startFooter) {
                
                self.tableView.startFooter = YES;
                [self.tableView reloadData];
                return ;
            }
            
            if (self.friendCycleApi.isLoadMore) {
                
                [self.tableView.mj_footer endRefreshing];
                if (cycles.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                NSMutableArray *indexpaths = @[].mutableCopy;
                for (int i = 0; i < cycles.count; i++) {
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:originCount + i inSection:0];
                    [indexpaths addObject:path];
                 }
                [self.tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationFade];
            }

        }];
    }];

}
#pragma mark - private method

- (void)resetTableView {
    
    [self.layoutArray removeAllObjects];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
    self.tableView.startFooter = NO;
    [self.friendCycleApi resetStatus];
    
}

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

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
        
        [self.friendCycleApi loadData];
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
    
    QYHomeTabBarViewController *tab = (QYHomeTabBarViewController *)self.tabBarController;
    tab.tabBar.hidden = NO;
    self.navigationItem.title = @"阅圈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(clickSearchButton:)];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.rightBarButtonItem = searchButton;
}


#pragma mark - target action
- (void)clickSearchButton:(UIBarButtonItem *)button {
    
    
    QYSearchViewController *search = [[QYSearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark - ClickCutom delegate

- (void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    [self resetTableView];
    if (index == 1) {
        
        self.type = 0;
        
    } else
        self.type = 1;
    [self loadData];
    MyLog(@"%ld",index);
}

- (void)clickPictureView:(QYCircleViewCell *)cell imageView:(UIImageView *)imageView {
    
    CGRect frame = [cell.statuView.pictureView convertRect:imageView.frame toView:self.view];
    QYPictureLookView *picturLook = [QYPictureLookView pictureLookViewWithImageView:imageView frame:frame];
    [picturLook show];
    
    
}

- (void)clickPraiseButton:(QYCircleViewCell *)cell dict:(NSDictionary *)dict {
    
    
}

- (void)clickCommpentButton:(QYCircleViewCell *)cell dict:(NSDictionary *)dict {
    
    
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
 
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYCircleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    if (!cell) {
        cell = [[QYCircleViewCell alloc] initWithCycleType:QYFriendCycleTypelist];
    }
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCircleViewCell *cycleCell = (QYCircleViewCell *)cell;
    QYFriendCycleCellLayout *layout = self.layoutArray[indexPath.row];
    cycleCell.layout = layout;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYFriendCycleDetailController *detail = [[QYFriendCycleDetailController alloc] init];
    QYFriendCycleCellLayout *layout = self.layoutArray[indexPath.row];
    QYDetailCycleLayout *detailLayout = [QYDetailCycleLayout friendStatusCellLayout:layout.status];
    detail.hidesBottomBarWhenPushed = YES;
    detail.layout = detailLayout;
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYFriendCycleCellLayout *layout = self.layoutArray[indexPath.row];
    return layout.height;
    
}

#pragma  mark - refesh 

- (void)tableViewFooterRefesh:(YYBasicTableView *)tableView {
    
    [self.friendCycleApi loadNext];
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
       _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        
    }
    return _tableView;
}
- (NSMutableArray *)layoutArray {
    
    if (!_layoutArray) {
        
        _layoutArray = [NSMutableArray array];
        
    }
    return _layoutArray;
}

- (QYReadFriendCycleApiManager *)friendCycleApi {
    
    if (!_friendCycleApi) {
        
        _friendCycleApi = [[QYReadFriendCycleApiManager alloc] init];
        _friendCycleApi.delegate  = self;
        _friendCycleApi.paramSource = self;
    }
    return _friendCycleApi;
}

- (QYCycleMessageReform *)cycleReform {
    
    if (!_cycleReform) {
        
        _cycleReform = [[QYCycleMessageReform alloc] init];
    }
    return _cycleReform;
}

- (NSMutableArray *)attentArray {
    
    if (!_attentArray) {
        
        _attentArray = [NSMutableArray array];
    }
    return _attentArray;
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
