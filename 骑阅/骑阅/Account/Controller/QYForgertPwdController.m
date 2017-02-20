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

@interface QYForgertPwdController ()<QYViewClickProtocol>
@property (nonatomic, strong) QYRegisterView *forgertView;
@property (nonatomic, strong) QYResetOrSetPwdView *resetView;

@property (nonatomic, strong) NSMutableArray *preViews;//记录前一个所处的view；
@property (nonatomic, weak) UIView *currentView;//记录当前所处的viw;


@end

@implementation QYForgertPwdController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.forgertView];
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


#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYRegisterView class]]) {
        
        if (index == 0) {
            
            MyLog(@"code send");
        }
        if (index == 1) {
            MyLog(@"click next setup");
            [self presentResetView];
            return;
        }
    }
}


#pragma mark - private method

-(void)addPanGesture {
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] init];
    pan.edges = UIRectEdgeLeft;
    [pan addTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
