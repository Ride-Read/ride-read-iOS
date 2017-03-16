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

@interface QYReadCycleController ()<QYViewClickProtocol,UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYCycleSelectView *selectView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *layoutArray;
@property (nonatomic, strong) QYReadFriendCycleApiManager *friendCycleApi;

@end

@implementation QYReadCycleController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    MyLog(@"%@",path);
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpContentView];
    [self.serialQueue addOperationWithBlock:^{
       
        [self.friendCycleApi loadData];
    }];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self setNavc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CTAPIManagParamSource 
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    return nil;
}

#pragma mark - CTAPIManagerCallback
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-1000];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSDictionary *dic1 = @{ksite:@"广州",kthumbs:@[@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"],ksiteLength:@"1000km",kusername:@"snow",kmsg:@"骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kstatus:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kcreated_at:@"8分钟qian",kcomment:@[@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"},@{kuid:@(1),kmsg:@"回复 json:不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"}],kpraise:@[@{},@{}]};
    QYFriendCycleCellLayout *layout1 = [QYFriendCycleCellLayout friendStatusCellLayout:dic1];
    
    NSDictionary *dic2 = @{ksite:@"广州",kthumbs:@[@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",],ksiteLength:@"1000km",kusername:@"snow",kmsg:@"骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kstatus:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kcreated_at:@"8分钟qian",kcomment:@[@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"},@{kuid:@(1),kmsg:@"回复 json:不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"}],kpraise:@[@{},@{}]};
    QYFriendCycleCellLayout *layout2 = [QYFriendCycleCellLayout friendStatusCellLayout:dic2];
    
    NSDictionary *dic3 = @{ksite:@"广州",kthumbs:@[@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"],ksiteLength:@"1000km",kusername:@"snow",kmsg:@"骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅骑阅",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kstatus:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kcreated_at:@"8分钟qian",kcomment:@[@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"},@{kuid:@(1),kmsg:@"回复 json:不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"}],kpraise:@[@{},@{}]};
    QYFriendCycleCellLayout *layout3 = [QYFriendCycleCellLayout friendStatusCellLayout:dic3];
    
    NSDictionary *dic4 = @{ksite:@"广州",kthumbs:@[@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"],ksiteLength:@"1000km",kusername:@"snow",kmsg:@"骑阅骑阅骑阅",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kstatus:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kcreated_at:@"8分钟qian",kcomment:@[@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"},@{kuid:@(1),kmsg:@"回复 json:不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"}],kpraise:@[@{},@{}]};
    QYFriendCycleCellLayout *layout4 = [QYFriendCycleCellLayout friendStatusCellLayout:dic4];
    
    NSDictionary *dic5 = @{ksite:@"广州",kthumbs:@[@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"],kcomment:@[@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"},@{kuid:@(1),kmsg:@"不错",kcreated_at:@(time),knickname:@"snow",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"}],kpraise:@[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}],ksiteLength:@"1000km",kusername:@"snow",kmsg:@"骑阅骑阅骑阅",kavater:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kstatus:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kcreated_at:@"8分钟qian"};
    QYFriendCycleCellLayout *layout5 = [QYFriendCycleCellLayout friendStatusCellLayout:dic5];


    [self.layoutArray addObject:layout1];
    [self.layoutArray addObject:layout2];
    [self.layoutArray addObject:layout3];
    [self.layoutArray addObject:layout4];
    [self.layoutArray addObject:layout5];
    [self.tableView reloadData];
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
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
    
    QYHomeTabBarViewController *tab = (QYHomeTabBarViewController *)self.tabBarController;
    tab.tabBar.hidden = NO;
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
    
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYCircleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    if (!cell) {
        cell = [[QYCircleViewCell alloc] initWithCycleType:QYFriendCycleTypelist];
    }
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
    detail.layout = detailLayout;
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYFriendCycleCellLayout *layout = self.layoutArray[indexPath.row];
    return layout.height;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
