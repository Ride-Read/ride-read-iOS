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
    [self.preViews addObject:self.forgertView];
    self.currentView = self.forgertView;
    [self addPanGesture];
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
        if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
            
            if (precent > 0.5) {
                
                [self.preViews removeAllObjects];
                [self dismissViewControllerAnimated:YES completion:nil];
                
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
