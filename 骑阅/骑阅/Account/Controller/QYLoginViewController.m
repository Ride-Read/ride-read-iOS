//
//  QYLoginViewController.m
//  骑阅
//
//  Created by 亮 on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginViewController.h"
#import "QYLoginHeaderView.h"
#import "define.h"
#import "QYLoginView.h"
#import "QYForgertPwdController.h"
#import "QYCustomPresentDelegate.h"
#import "QYLoginApiManager.h"
#import "MBProgressHUD+LLHud.h"
#import "QYHomeTabBarViewController.h"


@interface QYLoginViewController ()<QYViewClickProtocol,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYLoginView *loginView;
@property (nonatomic, strong) QYLoginApiManager *loginApiManager;

@end

@implementation QYLoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.loginView.frame = self.view.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    
    MyLog(@"dealloc:%@",[self class]);
}
#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYLoginView class]]) {
        
        if (index == 0) {
            MyLog(@"click next setup");
            [self.loginApiManager loadData];
            return;
        }
        if (index == 1) {
            
            self.presented = YES;
            QYForgertPwdController *forgert = [[QYForgertPwdController alloc] init];
            forgert.modalPresentationStyle = UIModalPresentationCustom;
            QYCustomPresentDelegate *delegate = [[QYCustomPresentDelegate alloc] init];
            forgert.transitioningDelegate = delegate;
            [self presentViewController:forgert animated:YES completion:nil];
            MyLog(@"click forgert");
            return;
        }
    }
}

#pragma mark - CTAPIParamSource
-(NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.loginApiManager) {
        
        NSString *username = self.loginView.phoneTextField.text;
        NSString *password = self.loginView.passwordTextField.text;
        return @{kusername:username?:@"",kpassword:password?:@""};
    }
    return nil;
}

#pragma mark - CTAPIManagerCallback
-(void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.loginApiManager) {
        //do something
    }
}
-(void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
#warning goto main controller for test
    
    [self gotoMainController];
    if (manager == self.loginApiManager) {
        
        //参数不能通过验证，具体可以看对应的Api
        if (manager.errorType == CTAPIBaseManagerErrorTypeParamsError) {
            
            [MBProgressHUD showMessageAutoHide:@"请输入正确的用户名或密码" view:self.view];
            return;
        }
        //请求已经发出，但服务器给了错误码
        if (manager.errorType == CTAPIBaseManagerErrorTypeNoContent) {
            
             [MBProgressHUD showMessageAutoHide:@"用户名或密码错误" view:self.view];
            return;
        }
        //其他情况
        [MBProgressHUD showMessageAutoHide:@"登录失败" view:self.view];
       
    }
    
}

#pragma mark - Private method
-(void)gotoMainController {
    
    QYHomeTabBarViewController *tab = [[QYHomeTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

#pragma mark - Targart action

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - setters and getters

-(QYLoginView *)loginView {
    
    if (!_loginView) {
        
        _loginView = [[QYLoginView alloc] init];
        _loginView.delegate = self;
       
    }
    return _loginView;
}

-(QYLoginApiManager *)loginApiManager {
    
    if (!_loginApiManager) {
        
        _loginApiManager = [[QYLoginApiManager alloc] init];
        _loginApiManager.delegate = self;
        _loginApiManager.paramSource = self;
    }
    return _loginApiManager;
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
