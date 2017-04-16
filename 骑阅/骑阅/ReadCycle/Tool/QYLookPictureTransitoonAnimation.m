//
//  QYLookPictureTransitoonAnimation.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLookPictureTransitoonAnimation.h"
#import "define.h"
#import "QYPictureLookController.h"

@implementation QYLookPictureTransitoonAnimation

+ (instancetype)picuteAnimationType:(QYlookPictureAnimationType)type from:(CGRect)from to:(CGRect)to{
    
    return [[self alloc] initWithAnimationType:type from:from to:to];
}

- (instancetype)initWithAnimationType:(QYlookPictureAnimationType)type from:(CGRect)from to:(CGRect)to{
    self = [super init];
    self.type = type;
    self.from = from;
    self.to = to;
    return self;
}
#pragma mark - AnimationDelegate
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    if (self.type == QYlookPictureAnimationTypePresnet) {
        
        [self presention:transitionContext];
    } else
        [self dismiss:transitionContext];
}

- (void)presention:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    toVC.view.frame = self.from;
    QYPictureLookController *ctr = (QYPictureLookController *)toVC;
    ctr.scrollView.frame = toVC.view.bounds;
    ctr.icon.frame = toVC.view.bounds;
    [UIView animateWithDuration:duration animations:^{
        
        toVC.view.frame = self.to;
        ctr.scrollView.frame = toVC.view.bounds;
        ctr.icon.frame = CGRectMake(kScreenWidth * ctr.currentIndex, 100, kScreenWidth, kScreenHeight-200);
        ctr.scrollView.contentOffset = CGPointMake(kScreenWidth * ctr.currentIndex, 0);
        [ctr.numberIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(20);
            make.centerX.equalTo(ctr.view.mas_centerX);
        }];

    } completion:^(BOOL finished) {
       
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    QYPictureLookController *ctr = (QYPictureLookController *)fromVC;
    ctr.view.frame = ctr.icon.bounds;
    ctr.scrollView.frame = ctr.icon.bounds;
    CGRect to = self.to;
    ctr.numberIndicator.hidden = YES;
    [UIView animateWithDuration:duration animations:^{
        
        fromVC.view.frame = self.to;
        ctr.scrollView.frame = CGRectMake(0, 0, to.size.width, to.size.height);
        ctr.icon.frame = ctr.scrollView.bounds;
        
    }completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];

}

@end
