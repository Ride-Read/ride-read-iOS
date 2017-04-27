//
//  QYSetViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/25.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSetViewController.h"
#import "YYBaiscTableViewCell.h"
#import "define.h"
#import "QYSetFooterView.h"
#import "UILabel+QYTitle.h"
#import "SDImageCache.h"
#import "QYAboutRideViewController.h"
#import "MBProgressHUD+LLHud.h"
#import "YYFMPromptView.h"
#import "QYChatkExample.h"
#import "QYLoginOrRegisterFatherController.h"
#import "QYLogoutApiManager.h"
@interface QYSetViewController ()<UIAlertViewDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYSetFooterView *footerView;
@property (nonatomic, weak) UILabel *ramLabel;
@property (nonatomic, strong) QYLogoutApiManager *logOutApi;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation QYSetViewController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"设置";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CTAPiManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.logOutApi) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kuid:uid};
    }
    return nil;
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.logOutApi) {
        
        [self.hud hide:YES];
        [MBProgressHUD showMessageAutoHide:@"退出成功" view:nil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [CTAppContext sharedInstance].currentUser = nil;
        [QYChatkExample invokeThisMethodBeforeLogoutSuccess:^{
            
            MyLog(@"登出成功");
            QYLoginOrRegisterFatherController *login = [[QYLoginOrRegisterFatherController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = login;
            
        } failed:^(NSError *error) {
            
            MyLog(@"登出失败");
        }];

    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.logOutApi) {
        
        [self.hud hide:YES];
        [MBProgressHUD showMessageAutoHide:@"退出失败" view:nil];
    }
}

#pragma mark - private method
- (void)setContentView {
    
    [self.tableView registerClass:[YYBaiscTableViewCell class] forCellReuseIdentifier:@"setCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.tableView.rowHeight = cl_caculation_3y(112);
    self.tableView.tableFooterView = self.footerView;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (UISwitch *)creaeSwithView {
    
    UISwitch *sch = [[UISwitch alloc] init];
    sch.onTintColor = [UIColor colorWithHexString:@"#52cac1"];
    [sch addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    return sch;
}
#pragma mark - target action

- (void)clickSwitch:(UISwitch *)sender {
    
    
}

- (void)clicklogOut:(UIButton *)sender {
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.logOutApi loadData];
        self.hud = [MBProgressHUD showMessage:@"登出中..." toView:nil];
    }];
    
    UIAlertController *al = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出账号?" preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:cancle];
    [al addAction:confirm];
    [self presentViewController:al animated:YES completion:nil];

}
#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    YYBaiscTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    cell.showBottomLine = YES;
    switch (indexPath.row) {
        case 0:
        {
            
            cell.textLabel.text = @"声音";
            UISwitch *audoi = [self creaeSwithView];
            audoi.tag = 0;
            audoi.selected = YES;
            [cell.contentView addSubview:audoi];
            [audoi mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(13.5);
            }];
            
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"震动";
            UISwitch *audoi = [self creaeSwithView];
            audoi.tag = 1;
            [cell.contentView addSubview:audoi];
            [audoi mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(13.5);
            }];
            
        }
            break;

        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"清理缓存";
            
           NSUInteger count = [[SDImageCache sharedImageCache] getDiskCount];
            UILabel *ram = [UILabel lableTitle:[NSString stringWithFormat:@"%ldM",count] font:14 * SizeScale3x color:@"#000000"];
            self.ramLabel = ram;
            [cell.contentView addSubview:ram];
            [ram mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.mas_equalTo(cl_caculation_3y(40));
                make.right.mas_equalTo(0);
            }];
           
        }
            break;

        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"关于骑阅";
            
        }
            break;

        case 4:
        {
         
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"使用指南";
 
        }
            break;

        default:
            break;
    }
    return cell;
    
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            case 2:
        {
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    
                    [MBProgressHUD showMessageAutoHide:@"清理完成" view:nil];
                    self.ramLabel.text = @"0M";
                }];
                
            }];
            
            UIAlertController *al = [UIAlertController alertControllerWithTitle:nil message:@"您确定要清理缓存?" preferredStyle:UIAlertControllerStyleAlert];
            [al addAction:cancle];
            [al addAction:confirm];
            [self presentViewController:al animated:YES completion:nil];
            break;
        }
        case 3:
        {
            
            UIStoryboard *set = [UIStoryboard storyboardWithName:@"QYSetStoryboard" bundle:nil];
            QYAboutRideViewController *aboutRide =    [set instantiateViewControllerWithIdentifier:@"aboutRide"];
            [self.navigationController pushViewController:aboutRide animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma makr - alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
      
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
           
            [MBProgressHUD showMessageAutoHide:@"清理完成" view:nil];
            self.ramLabel.text = @"0M";
        }];
    }
}

#pragma mark - setter and getters

- (QYSetFooterView *)footerView {
    
    if (!_footerView) {
        
        _footerView = [QYSetFooterView setFooterView:self action:@selector(clicklogOut:) title:@"退出账号"];
        _footerView.frame = CGRectMake(0, 0, kScreenWidth, cl_caculation_3y(144));
    }
    return _footerView;
}

- (QYLogoutApiManager *)logOutApi {
    
    if (!_logOutApi) {
        
        _logOutApi = [[QYLogoutApiManager alloc] init];
        _logOutApi.delegate = self;
        _logOutApi.paramSource = self;
    }
    return _logOutApi;
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
