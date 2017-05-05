//
//  QYAboutRideViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/25.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAboutRideViewController.h"
#import "QYVersionUpdateApiManager.h"
#import "define.h"
#import "QYVsersionReform.h"
#import "QYBasicWebviewController.h"
#import "YYUpdateVersionView.h"

@interface QYAboutRideViewController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYVersionUpdateApiManager *versionApi;
@property (nonatomic, strong) QYVsersionReform *versionRefrom;
@property (nonatomic, assign) BOOL update;
@property (nonatomic, copy) NSString *link;

@end

@implementation QYAboutRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"关于骑阅";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)loadData {
    
    [self.versionApi loadData];
}

- (void)clickUpdateAction {
    
    if (self.update) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.link]];
    } else
        [MBProgressHUD showMessageAutoHide:@"未检测到新版本" view:nil];
}

- (void)clickConactAction {
    
    QYBasicWebviewController *webView = [[QYBasicWebviewController alloc] init];
    webView.title = @"联系骑阅";
    [self.navigationController pushViewController:webView animated:YES];
    
}
#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            //[self clickUpdateAction];
            
        }
            break;
            case 1:
        {
            
            [self clickConactAction];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - CTAPIManagerParamSource 

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid?:@(0),@"version_type":@(2)};
}

#pragma mark  - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
     NSDictionary *info = [self.versionApi fetchDataWithReformer:self.versionRefrom];
    if ([info[@"update"] integerValue] == 1) {
        
        self.update = YES;
    }
    self.link = info[klink];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
//    [MBProgressHUD showMessageAutoHide:@"版本信息加载失败" view:nil];
}

#pragma mark - getter and setter

- (QYVersionUpdateApiManager *)versionApi {
    
    if (!_versionApi) {
        
        _versionApi = [[QYVersionUpdateApiManager alloc] init];
        _versionApi.delegate = self;
        _versionApi.paramSource = self;
    }
    
    return _versionApi;
}

- (QYVsersionReform *)versionRefrom {
    
    
    if (!_versionRefrom) {
        
        _versionRefrom = [[QYVsersionReform alloc] init];
    }
    return _versionRefrom;
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
