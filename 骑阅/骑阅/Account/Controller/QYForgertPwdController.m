//
//  QYForgertPwdController.m
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYForgertPwdController.h"
#import "define.h"
#import "QYRegisterView.h"
#import "QYResetOrSetPwdView.h"
#import "QYForgetApiManager.h"
#import "NSString+QYRegular.h"
#import "MBProgressHUD+LLHud.h"
#import "QYUserReform.h"
#import "QYPhoneCodeApiManager.h"
#import "MBProgressHUD+LLHud.h"

@interface QYForgertPwdController ()<QYViewClickProtocol,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYRegisterView *forgertView;
@property (nonatomic, strong) QYResetOrSetPwdView *resetView;

@property (nonatomic, strong) NSMutableArray *preViews;//记录前一个所处的view；
@property (nonatomic, weak) UIView *currentView;//记录当前所处的viw;
@property (nonatomic, strong) QYForgetApiManager *forgetApi;
@property (nonatomic, getter=isCorrectSMSCode) BOOL correctSMSCode;
@property (nonatomic, strong) QYPhoneCodeApiManager *phoneApi;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, strong) QYUserReform *userReform;
@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation QYForgertPwdController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.forgertView];
    [self.preViews addObject:self.forgertView];
    self.currentView = self.forgertView;
    [self addPanGesture];
    [MBProgressHUD showMessageAutoHide:@"右滑返回哦！" view:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.forgertView.frame = self.view.bounds;
}
-(void)dealloc {
    
    MyLog(@"dealloc:%@",[self class]);
}

#pragma mark - target action

-(void)panAction:(UIScreenEdgePanGestureRecognizer *) gesture {
    
    if (self.preViews.count == 1) {
        
        CGPoint translation = [gesture translationInView:self.view];
        CGFloat translactionBase = self.view.bounds.size.width/3;
        CGFloat translactionAbs = translation.x > 0?translation.x:-translation.x;
        CGFloat precent = translactionAbs > translactionBase ? 1.0:translactionAbs/translactionBase;
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            //self.startPoint = translation;
            MyLog(@"began");
        }
        if (gesture.state == UIGestureRecognizerStateChanged) {
            /*
             if (precent > 0.5) {
             
             [UIView animateWithDuration:0.3 animations:^{
             
             preView.frame = CGRectMake(preFrame.origin.x + kScreenWidth, preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             } completion:nil];
             
             [UIView animateWithDuration:0.3 animations:^{
             
             self.currentView.frame = CGRectMake(currentFrame.origin.x + kScreenWidth * precent, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
             } completion:^(BOOL finished) {
             
             [self.currentView removeFromSuperview];
             self.currentView = nil;
             }];
             self.currentView = [self.preViews objectAtIndex:self.preViews.count -1];
             [self.preViews removeObjectAtIndex:self.preViews.count - 1];
             [sender setTranslation:CGPointZero inView:self.view];
             
             } else {
             
             [UIView animateWithDuration:0.3 animations:^{
             
             preView.frame = CGRectMake(preFrame.origin.x + kScreenWidth * precent, preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             } completion:^(BOOL finished) {
             
             preView.frame = CGRectMake(-kScreenWidth,preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             
             }];
             
             [UIView animateWithDuration:0.3 animations:^{
             
             self.currentView.frame = CGRectMake(currentFrame.origin.x + kScreenWidth * precent, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
             } completion:^(BOOL finished) {
             
             self.currentView.frame = CGRectMake(0,preFrame.origin.y, preFrame.size.width, preFrame.size.height);;
             }];
             
             }
             NSLog(@"change");
             */
        }
        if (gesture.state == UIGestureRecognizerStateEnded ) {
            
            if (precent > 0.5) {
                
                [self.preViews removeAllObjects];
                self.view.userInteractionEnabled = NO;
                if ([self.delegate respondsToSelector:@selector(customTransitonDissmiss:)]) {
                    
                    [self.delegate customTransitonDissmiss:self];
                }
                
            }
            MyLog(@"end");
        }

    } else {
        
        CGPoint translation = [gesture translationInView:self.view];
        CGFloat translactionBase = self.view.bounds.size.width/3;
        CGFloat translactionAbs = translation.x > 0?translation.x:-translation.x;
        CGFloat precent = translactionAbs > translactionBase ? 1.0:translactionAbs/translactionBase;
        UIView *preView = self.preViews[self.preViews.count - 1];
        CGRect preFrame = preView.frame;
        CGRect currentFrame = self.currentView.frame;
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            //self.startPoint = translation;
            MyLog(@"began");
        }
        if (gesture.state == UIGestureRecognizerStateChanged) {
            /*
             if (precent > 0.5) {
             
             [UIView animateWithDuration:0.3 animations:^{
             
             preView.frame = CGRectMake(preFrame.origin.x + kScreenWidth, preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             } completion:nil];
             
             [UIView animateWithDuration:0.3 animations:^{
             
             self.currentView.frame = CGRectMake(currentFrame.origin.x + kScreenWidth * precent, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
             } completion:^(BOOL finished) {
             
             [self.currentView removeFromSuperview];
             self.currentView = nil;
             }];
             self.currentView = [self.preViews objectAtIndex:self.preViews.count -1];
             [self.preViews removeObjectAtIndex:self.preViews.count - 1];
             [sender setTranslation:CGPointZero inView:self.view];
             
             } else {
             
             [UIView animateWithDuration:0.3 animations:^{
             
             preView.frame = CGRectMake(preFrame.origin.x + kScreenWidth * precent, preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             } completion:^(BOOL finished) {
             
             preView.frame = CGRectMake(-kScreenWidth,preFrame.origin.y, preFrame.size.width, preFrame.size.height);
             
             }];
             
             [UIView animateWithDuration:0.3 animations:^{
             
             self.currentView.frame = CGRectMake(currentFrame.origin.x + kScreenWidth * precent, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
             } completion:^(BOOL finished) {
             
             self.currentView.frame = CGRectMake(0,preFrame.origin.y, preFrame.size.width, preFrame.size.height);;
             }];
             
             }
             NSLog(@"change");
             */
        }
        if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
            
            if (precent > 0.5) {
                
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    preView.frame = CGRectMake(preFrame.origin.x + kScreenWidth, preFrame.origin.y, preFrame.size.width, preFrame.size.height);
                } completion:nil];
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.currentView.frame = CGRectMake(currentFrame.origin.x + kScreenWidth , currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
                } completion:^(BOOL finished) {
                    
                    [self.currentView removeFromSuperview];
                    self.currentView = nil;
                    self.currentView = [self.preViews objectAtIndex:self.preViews.count - 1];
                    [self.preViews removeObjectAtIndex:self.preViews.count - 1];
                    
                }];
                
                
            }
            MyLog(@"end");
        }

    }
}


#pragma mark - CTAPIManangParmaSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.forgetApi) {
        
        NSString *username = self.forgertView.phoneTextField.text;
        NSString *pwd = self.resetView.pwd.text;
        return @{kphonenumber:username?:@"",knew_password:pwd?:@""};
    }
    if (manager == self.phoneApi) {
        
        NSString *string = self.forgertView.phoneTextField.text;
        return @{kphonenumber:string?:@""};
    }
    return nil;
}

#pragma mark - CTAPIManageCallBackdelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.phoneApi) {
        
        self.forgertView.codeButton.enabled = YES;
        [self.hud hide:YES];
        self.phoneCode = [self.phoneApi fetchDataWithReformer:self.userReform];
        [MBProgressHUD showMessageAutoHide:@"验证码发送成功" view:nil];
        self.correctSMSCode = YES;
        return;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    [MBProgressHUD showMessageAutoHide:@"修改成功" view:self.view];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.phoneApi) {
        
        [self.hud hide:YES];
        self.forgertView.codeButton.enabled = YES;
        NSString *msg = [self.phoneApi fetchDataWithReformer:self.userReform];
        [MBProgressHUD showMessageAutoHide:msg view:nil];
        return;
        
    }

    [MBProgressHUD showMessageAutoHide:@"修改失败" view:self.view];
}
#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYRegisterView class]]) {
        
        if (index == 0) {
            
            self.hud = [MBProgressHUD showMessage:@"发送中..." toView:nil];
            [self.serialQueue addOperationWithBlock:^{
                
                [self.phoneApi loadData];
            }];
            self.forgertView.codeButton.enabled = NO;
            WEAKSELF(_self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                _self.forgertView.codeButton.enabled = YES;
            });
        }
        if (index == 1) {
            MyLog(@"click next setup");
            if (self.isCorrectSMSCode && [self.forgertView.verifyTextField.text isEqualToString:self.phoneCode])
            {
                
                [self presentResetView];
            } else
            {
                if (!self.isCorrectSMSCode)
                {
                    [MBProgressHUD showMessageAutoHide:@"请先获取验证码" view:nil];
                    return;
                }
                
                [MBProgressHUD showMessageAutoHide:@"验证码输入错误" view:nil];
            }
            
            return;
        }
    }
    
    if ([customView isKindOfClass:[QYResetOrSetPwdView class]]) {
        
        NSString *pwd = self.resetView.pwd.text;
        NSString *repwd = self.resetView.confirmPwd.text;
        if (pwd.length < 6 || repwd.length < 6) {
            
            [MBProgressHUD showMessageAutoHide:@"密码不小于6位数" view:self.view];
            return;
        }
        if ([pwd isEqualToString:repwd]) {
            
            [self.forgetApi loadData];
        
        } else {
            
            [MBProgressHUD showMessageAutoHide:@"两次输入不一致" view:self.view];
        }
        
        
    }
}


#pragma mark - private method

-(void)addPanGesture {
    
    UIScreenEdgePanGestureRecognizer *leftPan = [[UIScreenEdgePanGestureRecognizer alloc] init];
    leftPan.edges = UIRectEdgeLeft;
    [leftPan addTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:leftPan];
    
    UIScreenEdgePanGestureRecognizer *dismissLeft = [[UIScreenEdgePanGestureRecognizer alloc] init];
    dismissLeft.edges = UIRectEdgeLeft;
    [dismissLeft addTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:dismissLeft];
    
}
- (void)presentResetView {
    
    [self.view addSubview:self.resetView];
    CGRect resetFrame = self.forgertView.frame;
    resetFrame.origin.x = kScreenWidth;
    self.resetView.frame = resetFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.forgertView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
       
    } completion:nil];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.resetView.frame = CGRectMake(resetFrame.origin.x - kScreenWidth, resetFrame.origin.y, resetFrame.size.width, resetFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.forgertView];
    self.currentView = self.resetView;
}

#pragma mark - Targart action

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - setters and getters

-(QYRegisterView *)forgertView {
    
    if (!_forgertView) {
        
        _forgertView = [[QYRegisterView alloc] init];
        _forgertView.type = QYForgertViewType;
        _forgertView.delegate = self;
        
    }
    return _forgertView;
}
-(QYResetOrSetPwdView *)resetView {
    
    if (!_resetView) {
        
        _resetView = [[QYResetOrSetPwdView alloc] init];
        _resetView.delegate = self;
    }
    return _resetView;
}
-(NSMutableArray *)preViews {
    
    if (!_preViews) {
        
        _preViews = [NSMutableArray array];
    }
    return _preViews;
}

- (QYForgetApiManager *)forgetApi {
    
    if (!_forgetApi) {
        
        _forgetApi = [[QYForgetApiManager alloc] init];
        _forgetApi.delegate = self;
        _forgetApi.paramSource = self;
    }
    return _forgetApi;
}

- (QYPhoneCodeApiManager *)phoneApi {
    
    if (!_phoneApi) {
        
        _phoneApi = [[QYPhoneCodeApiManager alloc] init];
        _phoneApi.delegate = self;
        _phoneApi.paramSource = self;
    }
    return _phoneApi;
}

- (QYUserReform *)userReform {
    
    if (!_userReform) {
        
        _userReform = [[QYUserReform alloc] init];
    }
    return _userReform;
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
