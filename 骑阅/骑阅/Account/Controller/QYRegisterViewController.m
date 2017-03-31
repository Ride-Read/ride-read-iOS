//
//  QYRegisterViewController.m
//  骑阅
//
//  Created by 亮 on 2017/2/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRegisterViewController.h"
#import "define.h"
#import "QYRegisterView.h"
#import "QYResetOrSetPwdView.h"
#import "QYInviteView.h"
#import "QYRideReadAccountView.h"
#import "MBProgressHUD+LLHud.h"
#import "QYVerifyCodeApiManager.h"
#import "QYGetQiNiuTokenApiManager.h"
#import "NSString+QYRegular.h"
#import "QYGetQiNiuTokenApiManager.h"
#import "QYQiuNiuUploadTool.h"
#import "QYQiuniuUploadCommand.h"
#import "QYQiuniuTokenCommand.h"
#import "NSString+QYDateString.h"
#import "QYUserRegisterApiManager.h"
#import "QYRegisterLogic.h"
#import "QYHomeTabBarViewController.h"


@interface QYRegisterViewController ()<QYViewClickProtocol,UIGestureRecognizerDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLCommandDataSource,CLCommandDelegate>
@property (nonatomic, strong) QYRegisterView *registerView;
@property (nonatomic, strong) QYResetOrSetPwdView *setView;
@property (nonatomic, strong) QYInviteView *invitePeopleView;
@property (nonatomic, strong) QYRideReadAccountView *rideInviteCodeView;
@property (nonatomic, assign) CGPoint startPoint;


@property (nonatomic, strong) NSMutableArray *preViews;//前面添加View所在的栈
@property (nonatomic, weak) UIView *currentView;//记录当前所处的viw;
@property (nonatomic, strong) QYVerifyCodeApiManager *verifyInviteCodeApiManager;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) QYQiuniuTokenCommand *commad;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) QYRegisterLogic *registerLogic;

/**
 标记是否通过手机验证的验证 default NO ,在对应API进行设置
 */
@property (nonatomic, getter=isCorrectSMSCode) BOOL correctSMSCode;

@end

@implementation QYRegisterViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.invitePeopleView];
    [self.preViews addObject:self.view];
    self.currentView = self.invitePeopleView;
    [self addPanGesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.invitePeopleView.frame = self.view.bounds;
}
-(void)dealloc {
    
    MyLog(@"dealloc:%@",[self class]);
}
#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYInviteView class]]) {
        
        if (index == 0) {
            
            [self.serialQueue addOperationWithBlock:^{
           
                [self.verifyInviteCodeApiManager loadData];
                
            }];
            self.hud = [MBProgressHUD showMessage:@"验证中..." toView:nil];
        }
    }
    
    if ([customView isKindOfClass:[QYRegisterView class]]) {
        
        if (index == 0) {
            
            NSString *string = self.registerView.phoneTextField.text;
           NSString *code =  [string verifyPhoneNumber:string];
            if (code) {
                
                self.correctSMSCode = YES;
                self.registerView.verifyTextField.textField.text = code;
            } else
            {
                self.correctSMSCode = NO;
                [MBProgressHUD showMessageAutoHide:@"获取失败" view:nil];
            }
            MyLog(@"code send");
        }
        if (index == 1) {
            MyLog(@"click next setup");
            if (self.isCorrectSMSCode)
            {
                
                [self presentSetView];
            } else
            {
                //[self presentSetView];
                [MBProgressHUD showMessageAutoHide:@"请先通过手机验证" view:nil];
            }

            return;
        }
        if (index == 2) {
            
            MyLog(@"click protocol");
            return;
        }
    }
    
    if ([customView isKindOfClass:[QYResetOrSetPwdView class]]) {
        
        if (index == 0) {
            
            NSString *pwd = self.setView.pwd.text;
            NSString *repwd = self.setView.confirmPwd.text;
            if (pwd.length < 6 || repwd.length < 6) {
                
                [MBProgressHUD showMessageAutoHide:@"密码不小于6位数" view:nil];
                return;
            }
            if ([pwd isEqualToString:repwd]) {
        
                [self presentSetInvitCodeView];
            } else {
                
                [MBProgressHUD showMessageAutoHide:@"两次输入不一致" view:nil];
            }
            
        }
    }
    
    if ([customView isKindOfClass:[QYRideReadAccountView class]]) {
        
        
        [self handleReadIconClick:index];
    }
    
}

#pragma mark - CLCoommandDataSource

- (NSDictionary *)paramsForcommand:(CLCommands *)command {
    
    return @{kfilename:self.filename,ktoken:@"jsonsnow",@"uid":@"jsonsnow"};
    
}

#pragma mark - CLCommandDelegate

- (void)command:(CLCommands *)commands didSuccess:(CTAPIBaseManager *)apiManager {
    
    
}

- (void)command:(CLCommands *)commands didFaildWith:(CTAPIBaseManager *)apiManager {
    
    [MBProgressHUD showMessageAutoHide:@"图片上传失败" view:nil];
}

#pragma mark - CTAPIParamSource
-(NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.verifyInviteCodeApiManager) {
        
        NSString * username = self.invitePeopleView.invitePeople.text;
        return @{kphonenumber:username?:@""};
    }
    
    if (manager == self.registerLogic.apiManager) {
        
        NSString *phone = self.registerView.phoneTextField.text;
        NSString *nickname = self.rideInviteCodeView.inviteCodeView.text;
        NSString *url = self.url;
        NSString *pwd = self.setView.pwd.text;
        return @{kphonenumber:phone?:@"",knickname:nickname?:@"",kface_url:url?:@"",kpassword:pwd?:@""};
    }
    
    return nil;
}

#pragma mark - CTAPIManagerCallback
-(void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.verifyInviteCodeApiManager) {
        
        [self.hud hide:YES];
        self.hud = nil;
        [self presentRegisterView];
        return;
    }
    
    if (manager == self.registerLogic.apiManager) {
        
        [MBProgressHUD showMessageAutoHide:@"注册成功" view:nil];
        [self gotoMainController];
    }
}

-(void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.verifyInviteCodeApiManager) {
        
        [self.hud hide:YES];
        self.hud = nil;
        if (manager.errorType == CTAPIBaseManagerErrorTypeParamsError) {
            
            [MBProgressHUD showMessageAutoHide:@"邀请码错误" view:nil];
            return;
        }
        
        if (manager.errorType == CTAPIBaseManagerErrorTypeNoContent) {
            
            [MBProgressHUD showMessageAutoHide:@"邀请码不存在" view:nil];
            [self presentRegisterView];
            
            return;
        }
        [MBProgressHUD showMessageAutoHide:@"认证失败" view:nil];
        
    }
    
    if (manager == self.registerLogic.apiManager) {
        
        if (self.url.length <= 0) {
            
            [MBProgressHUD showMessageAutoHide:@"请上传图像" view:nil];
            return;
        }
        if (manager.errorType == CTAPIBaseManagerErrorTypeParamsError) {
            
            [MBProgressHUD showMessageAutoHide:@"昵称错误" view:nil];
            return;
        }
        [MBProgressHUD showMessageAutoHide:@"注册失败" view:nil];
    }
    
}

#pragma mark - target action
-(void)panAction:(UIPanGestureRecognizer *)sender {
    
    if (self.preViews.count == 1) {
        
        return;
    }
    CGPoint translation = [sender translationInView:nil];
    CGFloat translactionBase = self.view.bounds.size.width/3;
    CGFloat translactionAbs = translation.x > 0?translation.x:-translation.x;
    CGFloat precent = translactionAbs > translactionBase ? 1.0:translactionAbs/translactionBase;
    UIView *preView = self.preViews[self.preViews.count - 1];
    CGRect preFrame = preView.frame;
    CGRect currentFrame = self.currentView.frame;
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.startPoint = translation;
        NSLog(@"began");
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
      
    }
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        
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
        NSLog(@"end");
    }
   
    
}
#pragma mark - image picker controller 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
   // NSURL *url = info[UIImagePickerControllerReferenceURL];
    WEAKSELF(_self);
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    self.hud = [MBProgressHUD showMessage:@"上传中" toView:nil];
    self.commad.complete = ^(QNResponseInfo *info, NSString *key, NSDictionary *resp){
        
        [_self.hud hide:YES];
        
        if (info.isOK) {
            
            [_self.rideInviteCodeView.icon.icon setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            _self.rideInviteCodeView.icon.title.hidden = YES;
            _self.url = key;
            
        } else {
           
            [MBProgressHUD showMessageAutoHide:@"上传失败" view:nil];
            
        }
        MyLog(@"%@",info);
    };
    self.filename = [NSString uploadFilename];
    self.commad.nextParams = @{kdata:data,kfilename:self.filename};
    [self.commad execute];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - private method

-(void)gotoMainController {
    
    QYHomeTabBarViewController *tab = [[QYHomeTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

- (void)handleReadIconClick:(NSInteger)index {
    
    if (index == 0) {
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:nil];
        
    } else {
        
        [self.registerLogic loadData];
    }
}

-(void)addPanGesture {
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] init];
    pan.edges = UIRectEdgeLeft;
    [pan addTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];

}

-(void)presentRegisterView {
    
    [self.view addSubview:self.registerView];
    CGRect registerFrame = self.invitePeopleView.frame;
    registerFrame.origin.x = kScreenWidth;
    self.registerView.frame = registerFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.invitePeopleView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        self.invitePeopleView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.registerView.frame = CGRectMake(registerFrame.origin.x - kScreenWidth, registerFrame.origin.y, registerFrame.size.width, registerFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.invitePeopleView];
    self.currentView = self.registerView;

}

- (void)presentSetView {
    
    [self.view addSubview:self.setView];
    CGRect resetFrame = self.registerView.frame;
    resetFrame.origin.x = kScreenWidth;
    self.setView.frame = resetFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.registerView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.setView.frame = CGRectMake(resetFrame.origin.x - kScreenWidth, resetFrame.origin.y, resetFrame.size.width, resetFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.registerView];
    self.currentView = self.setView;
}


- (void)presentSetInvitCodeView {
    
    
    [self.view addSubview:self.rideInviteCodeView];
    CGRect setInviteViewFrame = self.setView.frame;
    setInviteViewFrame.origin.x = kScreenWidth;
    self.rideInviteCodeView.frame = setInviteViewFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.setView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:nil];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.rideInviteCodeView.frame = CGRectMake(setInviteViewFrame.origin.x - kScreenWidth, setInviteViewFrame.origin.y, setInviteViewFrame.size.width, setInviteViewFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.setView];
    self.currentView = self.rideInviteCodeView;

}
#pragma mark - Targart action

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - setters and getters

-(QYRegisterView *)registerView {
    
    if (!_registerView) {
        
        _registerView = [[QYRegisterView alloc] init];
        _registerView.delegate = self;
        
    }
    return _registerView;
}
-(QYResetOrSetPwdView *)setView {
    
    if (!_setView) {
        
        _setView = [[QYResetOrSetPwdView alloc] initWithStyle:QYResetViewStyleSet];
        _setView.delegate = self;
    }
    return _setView;
}
-(QYInviteView *)invitePeopleView {
    
    if (!_invitePeopleView) {
        
        _invitePeopleView = [[QYInviteView alloc] init];
        _invitePeopleView.delegate = self;
    }
    return _invitePeopleView;
}
-(QYRideReadAccountView *)rideInviteCodeView {
    
    if (!_rideInviteCodeView) {
        
        _rideInviteCodeView = [[QYRideReadAccountView alloc] init];
        _rideInviteCodeView.delegate = self;
    }
    return _rideInviteCodeView;
    
}
-(NSMutableArray *)preViews {
    
    if (!_preViews) {
        
        _preViews = [NSMutableArray array];
    }
    return _preViews;
}
-(QYVerifyCodeApiManager *)verifyInviteCodeApiManager {
    
    if (!_verifyInviteCodeApiManager) {
        
        _verifyInviteCodeApiManager = [[QYVerifyCodeApiManager alloc] init];
        _verifyInviteCodeApiManager.delegate = self;
        _verifyInviteCodeApiManager.paramSource = self;
    }
    return _verifyInviteCodeApiManager;
}

- (QYQiuniuTokenCommand *)commad {
    
    if (!_commad) {
        
        _commad = [[QYQiuniuTokenCommand alloc] init];
        _commad.dataSource = self;
        _commad.delegate = self;
    }
    return _commad;
}
- (QYRegisterLogic *)registerLogic {
 
    if (!_registerLogic) {
        
        _registerLogic = [[QYRegisterLogic alloc] init];
        _registerLogic.paramSource = self;
        _registerLogic.delegate = self;
    }
    return _registerLogic;
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
