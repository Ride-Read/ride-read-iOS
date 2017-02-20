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


@interface QYLoginViewController ()<QYViewClickProtocol>
@property (nonatomic, strong) QYLoginView *loginView;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
