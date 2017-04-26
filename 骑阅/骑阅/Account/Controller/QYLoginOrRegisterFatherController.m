//
//  QYLoginOrRegisterFatherController.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginOrRegisterFatherController.h"
#import "QYLoginHeaderView.h"
#import "define.h"
#import "Masonry.h"
#import "QYOtherLoginView.h"
#import "QYLoginViewController.h"
#import "QYRegisterViewController.h"
#import "QYForgertPwdController.h"

@interface QYLoginOrRegisterFatherController ()<QYViewClickProtocol>
@property (nonatomic, strong) QYLoginHeaderView *headerView;
@property (nonatomic, strong) QYOtherLoginView *otherLoginView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) QYLoginViewController *logController;
@property (nonatomic, strong) QYRegisterViewController *registerController;
@property (nonatomic, strong) QYForgertPwdController *forgertController;

/**
 
 忘记密码相关
 */
@property (nonatomic, assign) BOOL isOnForgertSendCode;
@property (nonatomic, assign) BOOL isOnForgertResetPwd;
@property (nonatomic, copy) NSString *forgertCode;
@property (nonatomic, copy) NSString *forgertPwd;
@property (nonatomic, copy) NSString *confirmForgertPwd;

@end

@implementation QYLoginOrRegisterFatherController

#pragma makr - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.otherLoginView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(163 * 2));
    }];
    [self.otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self createLogController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method
- (void)createLogController {
    
    self.logController = [[QYLoginViewController alloc] init];
    [self.logController willMoveToParentViewController:self];
    [self addChildViewController:self.logController];
    [self.view addSubview:self.logController.view];
    self.logController.view.frame = CGRectMake(0, cl_caculation_y(163 * 2), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [self.logController didMoveToParentViewController:self];

}
- (void)backCreateController {
    
    self.logController = [[QYLoginViewController alloc] init];
    [self.logController willMoveToParentViewController:self];
    [self addChildViewController:self.logController];
    [self.view addSubview:self.logController.view];
    self.logController.view.frame = CGRectMake(-kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [UIView animateWithDuration:0.3 animations:^{
        
        self.logController.view.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.logController didMoveToParentViewController:self];

}

- (void)removeLogControoler {
    
    [self.logController willMoveToParentViewController:nil];
    [self.logController removeFromParentViewController];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.logController.view.frame = CGRectMake(-kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.logController.view removeFromSuperview];
    [self.logController didMoveToParentViewController:nil];
    self.logController = nil;
    
    
}

- (void)createRegisterController {
    
    
    self.registerController = [[QYRegisterViewController alloc] init];
    [self.registerController willMoveToParentViewController:self];
    [self addChildViewController:self.registerController];
    [self.view addSubview:self.registerController.view];
    self.registerController.view.frame = CGRectMake(kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [UIView animateWithDuration:0.3 animations:^{
        
        self.registerController.view.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.registerController didMoveToParentViewController:self];

}

- (void)removeRegisterController {
    
    
    [self.registerController willMoveToParentViewController:nil];
    [self.registerController removeFromParentViewController];
    [self.registerController.view removeFromSuperview];
    [self.registerController didMoveToParentViewController:nil];
    self.registerController = nil;
}

- (void)createForgertController {
    
    self.forgertController = [[QYForgertPwdController alloc] init];
    [self.forgertController willMoveToParentViewController:self];
    [self addChildViewController:self.forgertController];
    [self.view addSubview:self.forgertController.view];
    self.forgertController.view.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [UIView animateWithDuration:0.3 animations:^{
        
        self.forgertController.view.frame = CGRectMake(0, cl_caculation_y(163 * 2), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.forgertController didMoveToParentViewController:self];
}

- (void)removeForgertController {
    
    [self.forgertController willMoveToParentViewController:nil];
    [self.forgertController removeFromParentViewController];
    [self.forgertController.view removeFromSuperview];
    [self.forgertController didMoveToParentViewController:nil];
    self.forgertController = nil;

}

#pragma mark - QYViewClickProtocol
-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYLoginHeaderView class]]) {
      
         MyLog(@"click %ld",(long)index);
        if (index == 0) {
            
            [self removeRegisterController];
            [self backCreateController];
            
            return;
        }
        if (index == 1) {
            if (self.presentedViewController) {
                
                [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
            }
            [self removeLogControoler];
            [self createRegisterController];
        }
        //self.transitioningDelegate = id;
        //self.modalPresentationStyle = UIModalPresentationCustom;
        return;
    }
    
    if ([customView isKindOfClass:[QYOtherLoginView class]]) {
        
         MyLog(@"click %ld",(long)index);
        return;
    }
   
}

#pragma -- <修改状态栏颜色>
- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return 1;
}


#pragma makr - getters and setters
-(QYLoginHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[QYLoginHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}
-(UIView *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(0, cl_caculation_y(163 * 2), kScreenWidth, kScreenHeight - cl_caculation_y(180) - cl_caculation_y(163 * 2));
       
    }
    return _contentView;
}

-(QYOtherLoginView *)otherLoginView {
    
    if (!_otherLoginView) {
        
        _otherLoginView = [[QYOtherLoginView alloc] init];
        _otherLoginView.delegate = self;
        _otherLoginView.hidden = YES;
    }
    return _otherLoginView;
}


@end
