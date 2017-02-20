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

@interface QYRegisterViewController ()<QYViewClickProtocol,UIGestureRecognizerDelegate>
@property (nonatomic, strong) QYRegisterView *registerView;
@property (nonatomic, strong) QYResetOrSetPwdView *setView;
@property (nonatomic, strong) QYInviteView *invitePeopleView;
@property (nonatomic, strong) QYRideReadAccountView *rideInviteCodeView;
@property (nonatomic, assign) CGPoint startPoint;


@property (nonatomic, strong) NSMutableArray *preViews;//记录前一个所处的view；
@property (nonatomic, weak) UIView *currentView;//记录当前所处的viw;

@end

@implementation QYRegisterViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.registerView];
    [self.preViews addObject:self.view];
    self.currentView = self.registerView;
    [self addPanGesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.registerView.frame = self.view.bounds;
}
-(void)dealloc {
    
    MyLog(@"dealloc:%@",[self class]);
}
#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYRegisterView class]]) {
        
        if (index == 0) {
            
            MyLog(@"code send");
        }
        if (index == 1) {
            MyLog(@"click next setup");
            [self presentSetView];
            return;
        }
        if (index == 2) {
            
            MyLog(@"click protocol");
            return;
        }
    }
    
    if ([customView isKindOfClass:[QYResetOrSetPwdView class]]) {
        
        if (index == 0) {
            
            [self presendtInvitPeopleView];
        }
    }
    
    if ([customView isKindOfClass:[QYInviteView class]]) {
        
        if (index == 0) {
            
            [self presentSetInvitCodeView];
        }
    }
}

#pragma mark - target action
-(void)panAction:(UIPanGestureRecognizer *)sender {
    
    if (self.preViews.count == 1) {
        
        return;
    }
    CGPoint translation = [sender translationInView:self.view];
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
#pragma mark - private method

-(void)addPanGesture {
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] init];
    pan.edges = UIRectEdgeLeft;
    [pan addTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];

}
- (void)presentSetView {
    
    [self.view addSubview:self.setView];
    CGRect resetFrame = self.registerView.frame;
    resetFrame.origin.x = kScreenWidth;
    self.setView.frame = resetFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.registerView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        self.registerView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.setView.frame = CGRectMake(resetFrame.origin.x - kScreenWidth, resetFrame.origin.y, resetFrame.size.width, resetFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.registerView];
    self.currentView = self.setView;
}

-(void)presendtInvitPeopleView {
    
    [self.view addSubview:self.invitePeopleView];
    CGRect inviteFrame = self.setView.frame;
    inviteFrame.origin.x = kScreenWidth;
    self.invitePeopleView.frame = inviteFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.setView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:nil];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.invitePeopleView.frame = CGRectMake(inviteFrame.origin.x - kScreenWidth, inviteFrame.origin.y, inviteFrame.size.width, inviteFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.setView];
    self.currentView = self.invitePeopleView;
}

- (void)presentSetInvitCodeView {
    
    
    [self.view addSubview:self.rideInviteCodeView];
    CGRect setInviteViewFrame = self.invitePeopleView.frame;
    setInviteViewFrame.origin.x = kScreenWidth;
    self.rideInviteCodeView.frame = setInviteViewFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.invitePeopleView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, self.view.bounds.size.height);
        
    } completion:nil];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.rideInviteCodeView.frame = CGRectMake(setInviteViewFrame.origin.x - kScreenWidth, setInviteViewFrame.origin.y, setInviteViewFrame.size.width, setInviteViewFrame.size.height);
        
    } completion:nil];
    [self.preViews addObject:self.invitePeopleView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
