//
//  QYReadMeController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadMeController.h"
#import "QYReadMeHeaderView.h"
#import "YYBasicTableView.h"
#import "define.h"
#import "QYPersonalDataViewController.h"
#import "QYAttentionViewController.h"
#import "QYFansUserViewController.h"
#import "QYRideUserLogic.h"
#import "QYUserReform.h"
#import "QYRideMyCycleController.h"
#import "QYRequstFrindViewController.h"
#import "QYCyclePostController.h"
#import "QYCycleCollectViewController.h"
#import "QYSetViewController.h"
#import "QYConversaitonListViewController.h"
#import "QYChatkExample.h"
#import "QYPersionMapApiManager.h"
#import "QYRecentlyCycleReform.h"

@interface QYReadMeController ()<UITableViewDelegate,UITableViewDataSource,QYReadMeHeaderViewDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, strong) QYReadMeHeaderView *headerView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) QYRideUserLogic *userLogic;
@property (nonatomic, strong) QYUserReform *userReform;
@property (nonatomic, strong) QYUser *user;
@property (nonatomic, assign) NSUInteger unreadCount;
@property (nonatomic, strong) QYPersionMapApiManager  *personApi;
@property (nonatomic, strong) QYRecentlyCycleReform *personReform;
@end

@implementation QYReadMeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addUnreadMessage) name:KReciveMessagNotiFation object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavc];
    [self loadUnreadMessage];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self loadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)loadData {
    
    [self.userLogic loadData];
    [self.serialQueue addOperationWithBlock:^{
       
        [self.personApi loadData];
    }];
}

- (void)loadUnreadMessage {
    
    [QYChatkExample fetchUnreadMessageNumber:^(NSUInteger unread) {
       
        NSString *unreadText = [NSString stringWithFormat:@"消息 %ld",unread];
        [self.headerView.messageButton setTitle:unreadText forState:UIControlStateNormal];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.unreadCount = unread;
        });
    }];
}
- (void)addUnreadMessage {
    
    NSString *unreadText = [NSString stringWithFormat:@"消息 %ld",++self.unreadCount];
    [self.headerView.messageButton setTitle:unreadText forState:UIControlStateNormal];
}
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}
- (void)setNavc {
    
    self.title = @"我的";
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.userLogic.apiManager) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:uid?:@(-1),ktype:@(1)};
    }
    
    if (manager == self.personApi) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:uid?:@(-1)};

    }
    return nil;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.userLogic.apiManager) {
        
        self.user = [self.userLogic fetchDataWithReformer:self.userReform];
        self.headerView.user = self.user;
    }
    
    if (manager == self.personApi) {
        
        
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.userLogic.apiManager) {
        
        
    }
    
    if (manager == self.personApi) {
        
        
    }
}

#pragma mark - headerView delegate

- (void)clickMessageButton:(QYReadMeHeaderView *)headerView {
    
    QYConversaitonListViewController *list = [[QYConversaitonListViewController alloc] init];
    list.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:list animated:YES];
}

- (void)clickIcon:(QYReadMeHeaderView *)headerView {
    
    QYPersonalDataViewController *person = [[QYPersonalDataViewController alloc] init];
    QYUser *user = [CTAppContext sharedInstance].currentUser;
    person.user = user;
    person.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:person animated:YES];
}
- (void)clickAttentionButton:(QYReadMeHeaderView *)headerView {
    
    QYAttentionViewController *attention = [[QYAttentionViewController alloc] init];
    attention.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:attention animated:YES];
}

- (void)clickFansButton:(QYReadMeHeaderView *)headerView {
    
    QYFansUserViewController *attention = [[QYFansUserViewController alloc] init];
    attention.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:attention animated:YES];

}
#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mecell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell showBottomLine];
    switch (indexPath.row) {
        case 0:
        {
            
            cell.imageView.image = [UIImage imageNamed:@"ride_me_send"];
            cell.textLabel.text = @"发个阅圈";
        }
            break;
        case 1:
        {
            
            cell.imageView.image = [UIImage imageNamed:@"ride_me_mycycle"];
            cell.textLabel.text = @"我的阅圈";
        }
            break;
        case 2:
        {
            
            cell.imageView.image = [UIImage imageNamed:@"ride_me_collect"];
            cell.textLabel.text = @"我的收藏";
        }
            break;
        case 3:
        {
            
            cell.imageView.image = [UIImage imageNamed:@"ride_me_request"];
            cell.textLabel.text = @"邀请好友";
        }
            break;
        case 4:
        {
            
            cell.imageView.image = [UIImage imageNamed:@"ride_me_set"];
            cell.textLabel.text = @"设置";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(110);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            case 0:
        {
            
            UIStoryboard *post = [UIStoryboard storyboardWithName:@"QYPostCycleStoryboard" bundle:nil];
            QYCyclePostController *postCtr = [post instantiateViewControllerWithIdentifier:@"postCntr"];;
            [self presentViewController:postCtr animated:YES completion:nil];
            break;
        }
        case 1:
        {
            QYRideMyCycleController *myCycle = [[QYRideMyCycleController alloc] init];
            myCycle.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCycle animated:YES];
            
        }
            break;
            case 2:
        {
            QYCycleCollectViewController *collect = [[QYCycleCollectViewController alloc] init];
            collect.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collect animated:YES];
            break;
            
        }
            case 3:
        {
            
            QYRequstFrindViewController *request = [[QYRequstFrindViewController alloc] init];
            request.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:request animated:YES];
            break;
        }
            case 4:
        {
            
            QYSetViewController *set = [[QYSetViewController alloc] init];
            set.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:set animated:YES];
        }
            
        default:
            break;
    }
}
#pragma mark - setter and getter
- (QYReadMeHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[QYReadMeHeaderView alloc] init];
        _headerView.delegate = self;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, cl_caculation_3y(560));
    }
    return _headerView;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mecell"];
    }
    return _tableView;
}

- (QYUserReform *)userReform {
    
    if (!_userReform) {
        _userReform = [[QYUserReform alloc] init];
    }
    return _userReform;
}

- (QYRideUserLogic *)userLogic {
    
    if (!_userLogic) {
        
        _userLogic = [[QYRideUserLogic alloc] init];
        _userLogic.delegate = self;
        _userLogic.paramSource = self;
    }
    return _userLogic;
}

- (QYRecentlyCycleReform *)personReform {
    
    if (!_personReform) {
        
        _personReform = [[QYRecentlyCycleReform alloc] init];
    }
    return _personReform;
}
- (QYPersionMapApiManager *)personApi {
    
    if (!_personApi) {
        
        _personApi = [[QYPersionMapApiManager alloc] init];
        _personApi.paramSource = self;
        _personApi.delegate = self;
    }
    return _personApi;
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
